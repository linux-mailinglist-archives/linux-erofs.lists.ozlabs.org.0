Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C64A5F9BD9
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Oct 2022 11:28:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MmDB14YWpz3cB6
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Oct 2022 20:28:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=delyorkcreative.academy header.i=@delyorkcreative.academy header.a=rsa-sha256 header.s=default header.b=gZwNzK+H;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=delyorkcreative.academy (client-ip=142.93.37.208; helo=delyorkcreative.delyorkcreative.academy; envelope-from=noreply@delyorkcreative.academy; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=delyorkcreative.academy header.i=@delyorkcreative.academy header.a=rsa-sha256 header.s=default header.b=gZwNzK+H;
	dkim-atps=neutral
X-Greylist: delayed 1435 seconds by postgrey-1.36 at boromir; Mon, 10 Oct 2022 20:28:32 AEDT
Received: from delyorkcreative.delyorkcreative.academy (delyorkcreative.delyorkcreative.academy [142.93.37.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MmD9r3GFjz305X
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Oct 2022 20:28:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=delyorkcreative.academy; s=default; h=Content-Type:MIME-Version:Message-ID:
	Date:Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mcUz+l3PdQunRzz2XZlzlpOKhf6ma8z6dGE2NBaP+Jo=; b=gZwNzK+HAKY+AyUOxHD5FHZSty
	K7j4VzKKVvOzZ3Rl6jXrmqANxp7ZAKJVR+wvsOvxJbzcZHqigFj6JyLl5egElOTTFNtYj/Iq9u6ju
	F9y1MI+ij1zqz15boczIUYQAs4CoVkCwP2DIEz+xML/tGKMI8nXaAIHgX7/7CIWH1cBu2leYoYi+n
	cZukUPLTQ4Ko1ijNQORM4fNXcW4mPdCmy/ux7AF4nXqTbVoT6yQio2NixI7RfYWll1W5ewRO6g1px
	v7I/uGOEaXtwuM8PHuwzXmQDUgnehEcVLTpsfb376J5nh8WlDMnteYqjEAOS6UxXgjPmX0NCG+1CB
	bJvuRaGw==;
Received: from [20.25.129.65] (port=62567 helo=bs1092)
	by delyorkcreative.delyorkcreative.academy with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <noreply@delyorkcreative.academy>)
	id 1ohoi7-0008An-Fe
	for linux-erofs@lists.ozlabs.org;
	Mon, 10 Oct 2022 09:04:31 +0000
thread-index: Adjch0450AIiQsR5TNaotA6Rx/e62g==
Thread-Topic: Your Order details: 55465025
From: =?utf-8?Q?support?= <noreply@delyorkcreative.academy>
To: <linux-erofs@lists.ozlabs.org>
Subject: Your Order details: 55465025
Date: Mon, 10 Oct 2022 09:04:29 -0000
Message-ID: <A05A2DE6BEA94D438A8E2FA0E23E7356@bs1092>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_260B_01D8DC87.4E39B4D0"
X-Mailer: Microsoft CDO for Windows 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - delyorkcreative.delyorkcreative.academy
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - delyorkcreative.academy
X-Get-Message-Sender-Via: delyorkcreative.delyorkcreative.academy: authenticated_id: noreply@delyorkcreative.academy
X-Authenticated-Sender: delyorkcreative.delyorkcreative.academy: noreply@delyorkcreative.academy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.

------=_NextPart_000_260B_01D8DC87.4E39B4D0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64


------=_NextPart_000_260B_01D8DC87.4E39B4D0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64

PFA+SW52b2ljZSBmb3IgbGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZzxCUj4tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLTxCUj5HRUVLIFRFQ0ggU1FVQUQgTExDOkJlc3QgT25saW5lIFRlY2huaWNh
bCBTb2x1dGlvbjxCUj5QUk9EVUNUIERFU0NSSVBUSU9OOjxCUj4tLS0tLS0tLS0tLS0tLS0tLS0t
PEJSPkEvQyBUeXBlIDotIFBlcnNvbmFsIEhvbWUgU3Vic2NyaXB0aW9uPEJSPlByb2R1Y3Q6LSBH
Sy9QQzM8QlI+RGV2aWNlOi0gVXB0byAzIERldmljZTxCUj5JbnZvaWNlIElEOiBHRUVLNTU0NjUw
MjU8QlI+UXVuYXRpdHk6LSAxPEJSPlRlbnVyZTotIDEgWWVhcjxCUj5QYXltZW50IE1vZGU6LSBP
bmxpbmU8QlI+RGVhciBsaW51eC1lcm9mc0BsaXN0cy5vemxhYnMub3JnLDxCUj5UaGFuayB5b3Ug
Zm9yIGNob29zaW5nIG91ciBzZXJ2aWNlcy5Zb3VyIFBlcnNvbmFsIFN1YnNjcmlwdGlvbiBHRUVL
U1FVQUQgQ0FSRSB3aWxsIEV4cGlyZSB0b2RheS4gVGhlIFN1YnNjcmlwdGlvbiBXaWxsIEF1dG8t
IFJlbmV3LjxCUj5Zb3VyIHN1YnNjcmlwdGlvbiBoYXMgYmVlbiByZW5ld2VkIGZvciBhbm90aGVy
IG9uZSB5ZWFyIHdpdGggR2Vlay1TcXVhZCBmb3ImbmJzcDsgJDMzOC4wNSwgYW5kIGFtb3VudCBo
YXMgYmVlbiBkZWR1Y3RlZCBmcm9tIHRoZSByZWdpc3RlcmVkIHBheW1lbnQgbWV0aG9kLCBvbiAx
MC0xMC0yMDIyLjwvUD4NCjxQPk5PVEU6PEJSPklmIHlvdSBoYXZlIGFueSBxdWVzdGlvbiBhYm91
dCB0aGlzIGludm9pY2Ugb3IgeW91IHdhbnQgdG8gY2FuY2VsIHRoZSBzdWJzY3JpcHRpb24sIHlv
dSBjYW4gY2FsbCBvdXQgb3VyIEN1c3RvbWVyIFN1cHBvcnQgYXQgOiArMSg4MDUpLTkyNC03MzAy
LjwvUD4NCjxQPlJlZ2FyZHMsPEJSPkdlZWsgU3F1YWQgVGVhbTwvUD4NCjxQPiZuYnNwOzwvUD4=

------=_NextPart_000_260B_01D8DC87.4E39B4D0--

