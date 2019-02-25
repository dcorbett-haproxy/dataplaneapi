// Code generated by go-swagger; DO NOT EDIT.

package tcp_request_rule

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the generate command

import (
	"net/http"

	middleware "github.com/go-openapi/runtime/middleware"
)

// DeleteTCPRequestRuleHandlerFunc turns a function with the right signature into a delete TCP request rule handler
type DeleteTCPRequestRuleHandlerFunc func(DeleteTCPRequestRuleParams, interface{}) middleware.Responder

// Handle executing the request and returning a response
func (fn DeleteTCPRequestRuleHandlerFunc) Handle(params DeleteTCPRequestRuleParams, principal interface{}) middleware.Responder {
	return fn(params, principal)
}

// DeleteTCPRequestRuleHandler interface for that can handle valid delete TCP request rule params
type DeleteTCPRequestRuleHandler interface {
	Handle(DeleteTCPRequestRuleParams, interface{}) middleware.Responder
}

// NewDeleteTCPRequestRule creates a new http.Handler for the delete TCP request rule operation
func NewDeleteTCPRequestRule(ctx *middleware.Context, handler DeleteTCPRequestRuleHandler) *DeleteTCPRequestRule {
	return &DeleteTCPRequestRule{Context: ctx, Handler: handler}
}

/*DeleteTCPRequestRule swagger:route DELETE /services/haproxy/configuration/tcp_request_rules/{id} TCPRequestRule deleteTcpRequestRule

Delete a TCP Request Rule

Deletes a TCP Request Rule configuration by it's ID from the specified parent.

*/
type DeleteTCPRequestRule struct {
	Context *middleware.Context
	Handler DeleteTCPRequestRuleHandler
}

func (o *DeleteTCPRequestRule) ServeHTTP(rw http.ResponseWriter, r *http.Request) {
	route, rCtx, _ := o.Context.RouteInfo(r)
	if rCtx != nil {
		r = rCtx
	}
	var Params = NewDeleteTCPRequestRuleParams()

	uprinc, aCtx, err := o.Context.Authorize(r, route)
	if err != nil {
		o.Context.Respond(rw, r, route.Produces, route, err)
		return
	}
	if aCtx != nil {
		r = aCtx
	}
	var principal interface{}
	if uprinc != nil {
		principal = uprinc
	}

	if err := o.Context.BindValidRequest(r, route, &Params); err != nil { // bind params
		o.Context.Respond(rw, r, route.Produces, route, err)
		return
	}

	res := o.Handler.Handle(Params, principal) // actually handle the request

	o.Context.Respond(rw, r, route.Produces, route, res)

}