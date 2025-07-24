<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartBarStock KE - Remote Bar Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Custom CSS for elements that need more styling than Tailwind provides */
        .sidebar {
            transition: all 0.3s ease;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .progress-bar {
            transition: width 0.5s ease;
        }
        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                left: -100%;
                z-index: 50;
            }
            .sidebar.active {
                left: 0;
            }
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
    <!-- Mobile Menu Button -->
    <button id="mobileMenuButton" class="md:hidden fixed top-4 left-4 z-50 bg-blue-600 text-white p-2 rounded-lg">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Sidebar -->
    <div id="sidebar" class="sidebar w-64 bg-blue-800 text-white h-screen fixed overflow-y-auto">
        <div class="p-4 flex items-center space-x-3 border-b border-blue-700">
            <img src="https://via.placeholder.com/40" alt="Logo" class="rounded-full">
            <h1 class="text-xl font-bold">SmartBarStock KE</h1>
        </div>
        
        <div class="p-4">
            <div class="flex items-center space-x-3 mb-6">
                <img src="https://via.placeholder.com/40" alt="User" class="rounded-full">
                <div>
                    <p class="font-semibold">Jane Doe</p>
                    <p class="text-blue-200 text-sm">Owner - Mombasa Bar</p>
                </div>
            </div>
            
            <nav>
                <ul class="space-y-2">
                    <li>
                        <a href="#" class="flex items-center space-x-3 p-3 rounded-lg bg-blue-700">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-blue-700">
                            <i class="fas fa-wine-bottle"></i>
                            <span>Inventory</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-blue-700">
                            <i class="fas fa-cash-register"></i>
                            <span>POS Sales</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-blue-700">
                            <i class="fas fa-chart-line"></i>
                            <span>Reports</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-blue-700">
                            <i class="fas fa-users"></i>
                            <span>Staff</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-blue-700">
                            <i class="fas fa-cog"></i>
                            <span>Settings</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        
        <div class="absolute bottom-0 w-full p-4 border-t border-blue-700">
            <a href="#" class="flex items-center space-x-3 p-3 rounded-lg hover:bg-blue-700">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="md:ml-64 min-h-screen">
        <!-- Top Navigation -->
        <header class="bg-white shadow-sm p-4 flex justify-between items-center">
            <h2 class="text-xl font-semibold text-gray-800">Dashboard Overview</h2>
            <div class="flex items-center space-x-4">
                <div class="relative">
                    <button class="text-gray-600 hover:text-gray-900">
                        <i class="fas fa-bell"></i>
                        <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full h-4 w-4 flex items-center justify-center">3</span>
                    </button>
                </div>
                <div class="relative">
                    <button id="userMenuButton" class="flex items-center space-x-2">
                        <img src="https://via.placeholder.com/32" alt="User" class="rounded-full">
                        <span class="hidden md:inline">Jane Doe</span>
                        <i class="fas fa-chevron-down text-xs"></i>
                    </button>
                    <div id="userMenu" class="hidden absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-50">
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Profile</a>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Settings</a>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Logout</a>
                    </div>
                </div>
            </div>
        </header>

        <!-- Dashboard Content -->
        <main class="p-4">
            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                <div class="dashboard-card bg-white rounded-lg shadow p-6">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="text-gray-500 text-sm">Total Stock Value</p>
                            <h3 class="text-2xl font-bold">KES 245,780</h3>
                        </div>
                        <div class="bg-blue-100 text-blue-600 p-2 rounded-lg">
                            <i class="fas fa-boxes"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="flex justify-between text-sm mb-1">
                            <span>This Month</span>
                            <span>+12%</span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2">
                            <div class="bg-blue-600 h-2 rounded-full progress-bar" style="width: 75%"></div>
                        </div>
                    </div>
                </div>
                
                <div class="dashboard-card bg-white rounded-lg shadow p-6">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="text-gray-500 text-sm">Today's Sales</p>
                            <h3 class="text-2xl font-bold">KES 32,450</h3>
                        </div>
                        <div class="bg-green-100 text-green-600 p-2 rounded-lg">
                            <i class="fas fa-receipt"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="flex justify-between text-sm mb-1">
                            <span>This Week</span>
                            <span>+8%</span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2">
                            <div class="bg-green-600 h-2 rounded-full progress-bar" style="width: 60%"></div>
                        </div>
                    </div>
                </div>
                
                <div class="dashboard-card bg-white rounded-lg shadow p-6">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="text-gray-500 text-sm">Low Stock Items</p>
                            <h3 class="text-2xl font-bold">8 Items</h3>
                        </div>
                        <div class="bg-yellow-100 text-yellow-600 p-2 rounded-lg">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="flex justify-between text-sm mb-1">
                            <span>Critical</span>
                            <span>3 Items</span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2">
                            <div class="bg-yellow-600 h-2 rounded-full progress-bar" style="width: 30%"></div>
                        </div>
                    </div>
                </div>
                
                <div class="dashboard-card bg-white rounded-lg shadow p-6">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="text-gray-500 text-sm">Staff On Duty</p>
                            <h3 class="text-2xl font-bold">4 Staff</h3>
                        </div>
                        <div class="bg-purple-100 text-purple-600 p-2 rounded-lg">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="flex justify-between text-sm mb-1">
                            <span>Active Shifts</span>
                            <span>2 Shifts</span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2">
                            <div class="bg-purple-600 h-2 rounded-full progress-bar" style="width: 50%"></div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Charts and Tables -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
                <!-- Sales Chart -->
                <div class="lg:col-span-2 bg-white rounded-lg shadow p-6">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-semibold">Weekly Sales Performance</h3>
                        <select class="bg-gray-100 border border-gray-300 rounded px-3 py-1 text-sm">
                            <option>This Week</option>
                            <option>Last Week</option>
                            <option>This Month</option>
                        </select>
                    </div>
                    <div class="h-64">
                        <!-- Chart placeholder - would be replaced with actual chart in production -->
                        <div class="w-full h-full bg-gray-100 rounded flex items-center justify-center">
                            <p class="text-gray-500">Sales Chart Visualization</p>
                        </div>
                    </div>
                </div>
                
                <!-- Top Selling Items -->
                <div class="bg-white rounded-lg shadow p-6">
                    <h3 class="text-lg font-semibold mb-4">Top Selling Items</h3>
                    <div class="space-y-4">
                        <div class="flex items-center justify-between">
                            <div class="flex items-center space-x-3">
                                <div class="bg-blue-100 text-blue-600 p-2 rounded-lg">
                                    <i class="fas fa-beer"></i>
                                </div>
                                <div>
                                    <p class="font-medium">Tusker Lager</p>
                                    <p class="text-sm text-gray-500">Beer</p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="font-medium">KES 45,200</p>
                                <p class="text-sm text-green-500">+15%</p>
                            </div>
                        </div>
                        
                        <div class="flex items-center justify-between">
                            <div class="flex items-center space-x-3">
                                <div class="bg-green-100 text-green-600 p-2 rounded-lg">
                                    <i class="fas fa-glass-whiskey"></i>
                                </div>
                                <div>
                                    <p class="font-medium">Johnnie Walker</p>
                                    <p class="text-sm text-gray-500">Whisky</p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="font-medium">KES 32,700</p>
                                <p class="text-sm text-green-500">+8%</p>
                            </div>
                        </div>
                        
                        <div class="flex items-center justify-between">
                            <div class="flex items-center space-x-3">
                                <div class="bg-yellow-100 text-yellow-600 p-2 rounded-lg">
                                    <i class="fas fa-wine-bottle"></i>
                                </div>
                                <div>
                                    <p class="font-medium">Drostdy-Hof</p>
                                    <p class="text-sm text-gray-500">Wine</p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="font-medium">KES 28,400</p>
                                <p class="text-sm text-red-500">-3%</p>
                            </div>
                        </div>
                        
                        <div class="flex items-center justify-between">
                            <div class="flex items-center space-x-3">
                                <div class="bg-purple-100 text-purple-600 p-2 rounded-lg">
                                    <i class="fas fa-cocktail"></i>
                                </div>
                                <div>
                                    <p class="font-medium">Signature Cocktail</p>
                                    <p class="text-sm text-gray-500">Cocktail</p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="font-medium">KES 24,100</p>
                                <p class="text-sm text-green-500">+22%</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Low Stock and Recent Activity -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Low Stock Items -->
                <div class="lg:col-span-2 bg-white rounded-lg shadow p-6">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-semibold">Low Stock Items</h3>
                        <button class="text-blue-600 text-sm font-medium">View All</button>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Item</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Current Stock</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10 bg-red-100 rounded-full flex items-center justify-center text-red-600">
                                                <i class="fas fa-beer"></i>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">Tusker Lager</div>
                                                <div class="text-sm text-gray-500">500ml Bottle</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Beer</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">12</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">Critical</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button class="text-blue-600 hover:text-blue-900">Order</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10 bg-yellow-100 rounded-full flex items-center justify-center text-yellow-600">
                                                <i class="fas fa-glass-whiskey"></i>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">Johnnie Walker</div>
                                                <div class="text-sm text-gray-500">750ml Bottle</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Whisky</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">3</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">Low</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button class="text-blue-600 hover:text-blue-900">Order</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 h-10 w-10 bg-yellow-100 rounded-full flex items-center justify-center text-yellow-600">
                                                <i class="fas fa-wine-bottle"></i>
                                            </div>
                                            <div class="ml-4">
                                                <div class="text-sm font-medium text-gray-900">Drostdy-Hof</div>
                                                <div class="text-sm text-gray-500">750ml Bottle</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">Wine</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">5</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">Low</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button class="text-blue-600 hover:text-blue-900">Order</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Recent Activity -->
                <div class="bg-white rounded-lg shadow p-6">
                    <h3 class="text-lg font-semibold mb-4">Recent Activity</h3>
                    <div class="space-y-4">
                        <div class="flex items-start space-x-3">
                            <div class="bg-blue-100 text-blue-600 p-2 rounded-full">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <div>
                                <p class="font-medium">New stock received</p>
                                <p class="text-sm text-gray-500">24 cases of Tusker Lager added to inventory</p>
                                <p class="text-xs text-gray-400">2 hours ago</p>
                            </div>
                        </div>
                        
                        <div class="flex items-start space-x-3">
                            <div class="bg-green-100 text-green-600 p-2 rounded-full">
                                <i class="fas fa-cash-register"></i>
                            </div>
                            <div>
                                <p class="font-medium">POS Sale completed</p>
                                <p class="text-sm text-gray-500">KES 8,450 sale by John (Bartender)</p>
                                <p class="text-xs text-gray-400">4 hours ago</p>
                            </div>
                        </div>
                        
                        <div class="flex items-start space-x-3">
                            <div class="bg-purple-100 text-purple-600 p-2 rounded-full">
                                <i class="fas fa-user-edit"></i>
                            </div>
                            <div>
                                <p class="font-medium">Staff update</p>
                                <p class="text-sm text-gray-500">Mary's shift changed to Evening</p>
                                <p class="text-xs text-gray-400">Yesterday</p>
                            </div>
                        </div>
                        
                        <div class="flex items-start space-x-3">
                            <div class="bg-red-100 text-red-600 p-2 rounded-full">
                                <i class="fas fa-exclamation-circle"></i>
                            </div>
                            <div>
                                <p class="font-medium">Stock alert</p>
                                <p class="text-sm text-gray-500">Tusker Lager stock below threshold</p>
                                <p class="text-xs text-gray-400">Yesterday</p>
                            </div>
                        </div>
                        
                        <div class="flex items-start space-x-3">
                            <div class="bg-indigo-100 text-indigo-600 p-2 rounded-full">
                                <i class="fas fa-file-invoice"></i>
                            </div>
                            <div>
                                <p class="font-medium">Report generated</p>
                                <p class="text-sm text-gray-500">Weekly sales report available</p>
                                <p class="text-xs text-gray-400">2 days ago</p>
                            </div>
                        </div>
                    </div>
                    <button class="mt-4 text-blue-600 text-sm font-medium">View All Activity</button>
                </div>
            </div>
        </main>
    </div>

    <!-- Mobile Bottom Navigation (for mobile only) -->
    <div class="md:hidden fixed bottom-0 left-0 right-0 bg-white shadow-lg flex justify-around items-center p-2 z-40">
        <a href="#" class="flex flex-col items-center text-blue-600 p-2">
            <i class="fas fa-tachometer-alt"></i>
            <span class="text-xs mt-1">Dashboard</span>
        </a>
        <a href="#" class="flex flex-col items-center text-gray-600 p-2">
            <i class="fas fa-wine-bottle"></i>
            <span class="text-xs mt-1">Stock</span>
        </a>
        <a href="#" class="flex flex-col items-center text-gray-600 p-2">
            <i class="fas fa-cash-register"></i>
            <span class="text-xs mt-1">POS</span>
        </a>
        <a href="#" class="flex flex-col items-center text-gray-600 p-2">
            <i class="fas fa-bell"></i>
            <span class="text-xs mt-1">Alerts</span>
        </a>
    </div>

    <script>
        // Mobile menu toggle
        document.getElementById('mobileMenuButton').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('active');
        });

        // User menu toggle
        document.getElementById('userMenuButton').addEventListener('click', function() {
            document.getElementById('userMenu').classList.toggle('hidden');
        });

        // Close user menu when clicking outside
        document.addEventListener('click', function(event) {
            const userMenu = document.getElementById('userMenu');
            const userMenuButton = document.getElementById('userMenuButton');
            
            if (!userMenu.contains(event.target) && !userMenuButton.contains(event.target)) {
                userMenu.classList.add('hidden');
            }
        });

        // Simulate loading animations
        document.querySelectorAll('.progress-bar').forEach(bar => {
            const width = bar.style.width;
            bar.style.width = '0';
            setTimeout(() => {
                bar.style.width = width;
            }, 100);
        });

        // Simulate chart loading
        setTimeout(() => {
            const chartPlaceholder = document.querySelector('.h-64 .bg-gray-100');
            if (chartPlaceholder) {
                chartPlaceholder.innerHTML = '<p class="text-gray-500">Chart loaded: Weekly sales data visualized</p>';
            }
        }, 1500);
    </script>
</body>
</html>
