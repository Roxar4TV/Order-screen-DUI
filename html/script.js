window.addEventListener('message', function (event) {
    let e = event.data;
    switch (e.action) {
        case "UPDATE_ORDERS":
            const orderedContainer = document.querySelector('.o-items');
            orderedContainer.innerHTML = '';
            if (Array.isArray(e.orders)) {
                e.orders.forEach(order => {
                    orderedContainer.insertAdjacentHTML('beforeend', `<p>#${order.id}</p>`);
                });
            }

            const completedContainer = document.querySelector('.c-items');
            completedContainer.innerHTML = '';
            if (Array.isArray(e.completedOrders)) {
                e.completedOrders.forEach(order => {
                    completedContainer.insertAdjacentHTML('beforeend', `<p>#${order.id}</p>`);
                });
            }
            break;
        case "DISPLAY":
            $('body').css('background', 'rgba(33, 30, 71, 1)');
            $('.container').css('display', 'flex');
            break;
        default: break;
    }
});