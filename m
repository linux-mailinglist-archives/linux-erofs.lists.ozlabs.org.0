Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106FE9E4D94
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Dec 2024 07:23:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y3kpM2n5Kz2yNs
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Dec 2024 17:22:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.238.17.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733379769;
	cv=none; b=kwe+HYHaEToHtMafHjUYeTiUerslfBjK9Okr3uBvuRDq+bgKYivAi0QRfotLgKQdsPGfED0bsCMkL6D6yugHO985+6bkRbTVK7h4gs3nJh6r41psJEtgDh/Gj8NmIm/VQLeZw45FdhEHsKuh9HfJlMVkQ7wvLXEeLVafhMFwDUc+H2dCKxRO/+osy7q+lhuySNyHdsRtBlMGlSGx6rW/C4Hgut5zRntBDwl/tiolDvr6jZIxyt9WeCxeZHMZJSPtFoktWixHjHbShaFW0N0wYJcPAOH1fJcs98Lt9A/xB9iWoPliYDlhWERY2uCqpOqClRiBwetftCdq4BNm1jKcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733379769; c=relaxed/relaxed;
	bh=s/BlUaqiUGg4Ozgz6YheB2vg4Z7LuCjjEaNv0EPny6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JeJ7Q0zpGTb3J2LEXiTkmQah4pW1AN0+fYMRII8fspho7zvIUoqXv+fFw1uxmpoWou21KlCXx4u5YrmbPobL4CyQbHZzq4PMS84AV5Pw/AJG48slt1nltqq1Ja1jU1UuGqCUlcXBw1csnh4IRY+DaS34Dio6/HOu+lUrlOuirZaiC8lAVtSbX3/CbB03QvpYPUyi2UVPZPhEwkBPPdT0MN4OXHPhnAsKQ5X1IjASLtoR4i+hO7HKzy1qdeq0BQZHRskTwWQlewmOFBuEdREukNoESoIY6FYP0eykkledQH7b0KTn+NsAEIbjxUdFLu0/rikmUwF2ypVgsGfH7sCAGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=e2visa.com; dkim=fail header.d=e2visa.com header.i=@e2visa.com header.a=rsa-sha256 header.s=default header.b=LLOYI5ai reason="key not found in DNS"; dkim-atps=neutral; spf=softfail (client-ip=23.238.17.190; helo=cvps3320319768.hostwindsdns.com; envelope-from=info@e2visa.com; receiver=lists.ozlabs.org) smtp.mailfrom=e2visa.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=e2visa.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="key not found in DNS" header.d=e2visa.com header.i=@e2visa.com header.a=rsa-sha256 header.s=default header.b=LLOYI5ai;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=e2visa.com (client-ip=23.238.17.190; helo=cvps3320319768.hostwindsdns.com; envelope-from=info@e2visa.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 30160 seconds by postgrey-1.37 at boromir; Thu, 05 Dec 2024 17:22:46 AEDT
Received: from cvps3320319768.hostwindsdns.com (unknown [23.238.17.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y3kpG4r86z2xbL
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Dec 2024 17:22:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=e2visa.com;
	 s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=s/BlUaqiUGg4Ozgz6YheB2vg4Z7LuCjjEaNv0EPny6g=; b=LLOYI5aimR7p+w8mAEFcTx0BLQ
	KTJs7hOugMWYJl3LSOAeh5TyzOc0zvAafln//2GdBcGE0Ag7Lz/BKia36gZ4WITS5ReQJtTw77tHZ
	0Ju042tuL7/vuEKAPhdSQcaG2lVZ1Kj8dW3ShCez/IMy5RDACoaGCDu8eFAD3FF77fVwV5Qda2xEO
	MYxO45oRpT9s2he1qSBYABBFHFzmwQ/FhFOMfC7Mx6k9/fWjNa+JAoQ4/MM3eWkERDIt5cMYKwWFg
	mIyObhrRa8394eP5PawtVj4/d90BmTKKen9KfPrg15RzXd3rRD1+sRcBdfnzLUOwwgP/NO10yOKKJ
	aOXtuVeQ==;
Received: from [45.141.215.165] (port=57167)
	by cvps3320319768.hostwindsdns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.91)
	(envelope-from <info@e2visa.com>)
	id 1tIxPd-0001oB-1M
	for linux-erofs@lists.ozlabs.org; Wed, 04 Dec 2024 17:00:01 -0500
From: "Sarah Rahal Armra" < info@e2visa.com>
To: linux-erofs@lists.ozlabs.org
Subject: About your Product #70353
Date: 4 Dec 2024 22:59:58 +0100
Message-ID: <20241204225958.C4CDB5757905D23F@e2visa.com>
MIME-Version: 1.0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cvps3320319768.hostwindsdns.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - e2visa.com
X-Get-Message-Sender-Via: cvps3320319768.hostwindsdns.com: authenticated_id: info@e2visa.com
X-Authenticated-Sender: cvps3320319768.hostwindsdns.com: info@e2visa.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=2.0 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HTML_MESSAGE,KHOP_HELO_FCRDNS,MAY_BE_FORGED,MIME_HTML_ONLY,
	RDNS_DYNAMIC,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=disabled
	version=4.0.0
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Reply-To: Sarah Rahal Armra <piaskowiechandel@zohomail.in>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<html><head>
<meta http-equiv=3D"X-UA-Compatible" content=3D"IE=3Dedge">
</head>
<body><p>Greetings, Sales Manager</p><p>We are interested in your product a=
nd to be shipped to Mexico's Port of Lazaro.</p><p>Do you continue to expor=
t?<br><br>Please inform us of the choices that are accessible to us.</p><p>=
Warm regards</p><p>Sarah Rahal Armra</p></body></html>
