Return-Path: <linux-erofs+bounces-2636-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA2/BiJOsGnFhgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2636-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 18:00:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274362552DB
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 18:00:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVg0h1Rzyz3bjb;
	Wed, 11 Mar 2026 03:52:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=34.75.115.141
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773161556;
	cv=none; b=U1bHL06RAG3RUfn0eemAtZ+BN23uitLE6xU5foscgsoRUejTzctwxqYPD4oVjptELvMK35he85usd6ZvF5u4hUSTS6KJ5fDt/sZxOfybO9aRYtL3gngf1qZ7X4MLoq0+TAaEUU7lJKKNQuPiiTobD+gtCSnQqXc8iiIHV0bmhYDv1qSbOI8nAizNdmWEgsCWMlVqVvRSmC+AjsHNiGLOdFTB0di+Lq7b+rtP7dIBi/dUNGqvkhSdhMnezonKH6s5ih6tEeshtEjpQPl8tcsyoXas3RfZmZk5ECtH5/oCLj09jEnlz+bPPjTWUE/1QVaQ5CZvSf/s7E/wlcRw9MMeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773161556; c=relaxed/relaxed;
	bh=LaKY2qUJoJ3n35Q7DYMkGazUQXJwVWYz921WeX9WlSI=;
	h=Content-Type:MIME-Version:From:To:Subject; b=FJDcTs9/1VoB9PKscMrFKE+XPF2GmfhxUsYfqYWabBkNB+m7ajhqQfRFfhftS6KpYv9jOQ9mhwNqyDml0LAHWZuEUs52hk9YZrN611GzkOdQv5EqeJabIcS1b6hf0OGLbbErUPtU/lE165UZqaxt3PSiMH0mGGolV4n+g5UfHiMaGStnF598zou8sQp5he/b0RlHF1t/WYOhR+y5epKBZ7Wz8fzBSes38pjTq/LkXOdb0/uhCpkwsjNLcWMt/y1Gp6q5B9Tu3PxjPq6UvqCczeNZkxEMKJCIcbpP5q4oPerYogkh3G7g5TLvJpz9am98W8/UuTMGzKiVTDAYVJWxqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=alkadicapitalinvest.com; spf=none (client-ip=34.75.115.141; helo=[10.88.0.3]; envelope-from=<>; receiver=lists.ozlabs.org) smtp.helo=[10.88.0.3]
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=alkadicapitalinvest.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.helo="[10.88.0.3]" (client-ip=34.75.115.141; helo=[10.88.0.3]; envelope-from=<>; receiver=lists.ozlabs.org)
X-Greylist: delayed 754 seconds by postgrey-1.37 at boromir; Wed, 11 Mar 2026 03:52:34 AEDT
Received: from [10.88.0.3] (141.115.75.34.bc.googleusercontent.com [34.75.115.141])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVg0f2l6sz30Lw
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 03:52:34 +1100 (AEDT)
Content-Type: multipart/related; boundary="===============1665266562744841407=="
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
From: ACMEI <ahmed.lulu@alkadicapitalinvest.com>
To: linux-erofs@lists.ozlabs.org
Subject: =?utf-8?q?Impact-Driven_Investment_Funding_Now_Available?=
X-Priority: 2
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.0 required=3.0 tests=HTML_MESSAGE,
	HTML_MIME_NO_HTML_TAG,KHOP_HELO_FCRDNS,MIME_HTML_ONLY,MISSING_DATE,
	MISSING_MID,NO_FM_NAME_IP_HOSTN,RDNS_DYNAMIC autolearn=disabled
	version=4.0.1
X-Spam-Report: 
	*  1.4 MISSING_DATE Missing Date: header
	*  0.1 MISSING_MID Missing Message-Id: header
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  0.1 MIME_HTML_ONLY BODY: Message only has text/html MIME parts
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  0.6 HTML_MIME_NO_HTML_TAG HTML-only message, but there is no HTML tag
	*  0.4 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
	*  0.0 NO_FM_NAME_IP_HOSTN No From name + hostname using IP address
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
Message-Id: <4fVg0h1Rzyz3bjb@lists.ozlabs.org>
Date: Wed, 11 Mar 2026 03:52:36 +1100 (AEDT)
X-Rspamd-Queue-Id: 274362552DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.50 / 15.00];
	SPAM_FLAG(5.00)[];
	DMARC_POLICY_QUARANTINE(1.50)[alkadicapitalinvest.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUBJ_EXCESS_QP(1.20)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MIME_HTML_ONLY(0.20)[];
	MAILLIST(-0.19)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/related];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-2636-lists,linux-erofs=lfdr.de];
	HAS_X_PRIO_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MIME_TRACE(0.00)[0:+,1:~];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[ahmed.lulu@alkadicapitalinvest.com,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: add header
X-Spam: Yes

--===============1665266562744841407==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

RGVhciBMaW51eC1lcm9mcywKIAo8cD5XZSBpbnZpdGUgeW91IHRvIGV4cGxvcmUgYSB1bmlxdWUg
b3Bwb3J0dW5pdHkgZGVzaWduZWQgZm9yIHZpc2lvbmFyeSBwcm9qZWN0IG93bmVycyBhbmQgZGlz
Y2VybmluZyBpbnZlc3RvcnMgc2Vla2luZyBsb25nLXRlcm0gdmFsdWUuPHA+CiAgICAKPHA+QXQg
dGhlIGhlYXJ0IG9mIG91ciBpbml0aWF0aXZlIGlzIGEgZHluYW1pYyBpbnZlc3RtZW50IGZpbmFu
Y2luZyBwcm9ncmFtIHRoYXQgcmVkZWZpbmVzIGNvbnZlbnRpb25hbCBmdW5kaW5nLiBXZSBwcm92
aWRlIGFjY2VzcyB0byBzdHJhdGVnaWMgY2FwaXRhbCB0aHJvdWdoIGxvdy1pbnRlcmVzdCBpbnZl
c3RtZW50IGxvYW5z4oCUb2ZmZXJlZCBhdCBhbiBleGNlcHRpb25hbCByYXRlIG9mIDIuNSUgcGVy
IGFubnVt4oCUc3BlY2lmaWNhbGx5IHRhaWxvcmVkIGZvciBwcm9qZWN0cyB3aXRoIHN0cm9uZyBw
b3RlbnRpYWwgdG8geWllbGQgcmV0dXJucyBvZiB1cCB0byAxMCUgd2l0aGluIHRoZSBkZWZpbmVk
IGludmVzdG1lbnQgcGVyaW9kLjxwPgo8cD5UaGlzIGlzbid0IGp1c3QgZmluYW5jaW5nOyBpdCdz
IGEgcGFydG5lcnNoaXAgYnVpbHQgdG8gc2NhbGUgYW1iaXRpb24sIGFjY2VsZXJhdGUgaW5ub3Zh
dGlvbiwgYW5kIGRyaXZlIG1lYXN1cmFibGUgZ3Jvd3RoLjxwPgoKPHA+SWYgdGhpcyBhbGlnbnMg
d2l0aCB5b3VyIGN1cnJlbnQgb3IgZnV0dXJlIGNhcGl0YWwgc3RyYXRlZ2llcywgd2Ugd291bGQg
d2VsY29tZSB0aGUgb3Bwb3J0dW5pdHkgdG8gZGlzY3VzcyBob3cgd2UgY2FuIGNvbGxhYm9yYXRl
IGFuZCBtb3ZlIHlvdXIgdmlzaW9uIGZvcndhcmQuPHA+Cgo8cD5Mb29raW5nIGZvcndhcmQgdG8g
ZXhwbG9yaW5nIHdoYXQgd2UgY2FuIGFjaGlldmXigJR0b2dldGhlci48cD4KCjxwPktpbmQgcmVn
YXJkcyw8cD4KCjxwPkFobWVkIEx1bHU8cD4KPHA+QnVzaW5lc3MgUmVsYXRpb25zaGlwIE1hbmFn
ZXI8cD4KPHA+QWwgS2FkaSBDYXBpdGFsIE1pZGRsZSBFYXN0IEludmVzdG1lbnQ8cD4=

--===============1665266562744841407==--

