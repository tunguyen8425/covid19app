<template>
    <div class="container">
        <div class="card card-default">
            <div class="card-header">
                <h3>Hospital manage</h3>
            </div>
            <div class="card-body">
                <hospitalList></hospitalList>
            </div>
        </div>
    </div>
</template>

<script>
    import hospitalList from '../../components/hospitalList.vue'
    export default {
        mounted() {
            //
        },
        components: {
            hospitalList
        }
    }
</script>
