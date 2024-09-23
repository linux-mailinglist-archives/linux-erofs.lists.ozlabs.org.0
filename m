Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AD497E4B0
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 03:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727056420;
	bh=bm9PIK55L9vBacxqG1qfVzWmU1tHqOu+50gbZGZIxRE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=VoWXaZ+ufSiSFjgKkl8EGjJ2hQpcmgFB0+gshXm5WzUXSjxrfHntZKgO4xVCFa7Nx
	 8OwUsOBo722eNIZWrr2YzL0TD3eBoGcheFdQoyK2OuiPZPh/HGbh3Deo3Ftim0niqO
	 q4L9oH3L8bLHWs9aV/GsEnCeTgiJYxJ3e/R2rnxAzfXOSKcWMNZfJE5WZIkEIgBhDT
	 7kyHLZ9HZZ05pLJ3NU7qNyQbn7zSHtcdMxZy70rxMY2pdXwo8bZFUU5rCoJf2wUn4p
	 73Ms1fEif6LOF5aXTRNuaEe9BYe/Ji15itlnKi9FHWoYlFKmrrfb639gnGCWWeGPdU
	 A8znIqm1dYV6Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBmHS0DZgz2yRG
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 11:53:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.239.33.245
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727056417;
	cv=none; b=i9kCXkeOYQMmTM3wT6cvzdBIDmEAXajGmhCx8+Yhpn2jtBmbQuHnA8Jlll6zG+VPf5n+8hsfe87pBS1y3xFBUInsuAgClPS777CoJ79T9Ar+lzuiZAexfZl9gaI8he+zlqZ6jRV1r3nmyBbfQSEUiK+hEDCo72Gp2/MdnoHswkEbi984II8ipcckSNvp7Ox+b7emovvytCvRK0Q+ra+PIOamp5181fKlsIcMpdXJBuNJqnJR+55U7ZllZWrRvSbANbapW8PSgaC+c0KKeoQQqtZyZLKjdLsLhITWrT8CusuIX6aGF0i99K0cpUVPXr3Wlaw4jB+QGh/3F3jMEJqdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727056417; c=relaxed/relaxed;
	bh=bm9PIK55L9vBacxqG1qfVzWmU1tHqOu+50gbZGZIxRE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hB25EwmwlGRxgfVl6hA5NsWJwmYOmvgliw3spIBWBHoEltrBXTQ0gGka3Keusmw2GX18hT04+bJ/lnJLYWnY3MWMcNxveZbRuNZ/Y4FrCYDzrpyKxK3WQdP3/QY6bUNVyrOeDuiDUyfaKdesr3QK8bSroq8JkHH4HJKXMMY5POgjZ/ad6x5hnTaG6+id4lIFLwu5igvBJw9Hs7nNKJlj6gnNztgx6t+qKWuNyGjhCsotV1AQ7SazTV6/2mJcDoYnuNDLhpRVtapiPGDy7jBmsh2uPeRF5HG8D2GE1ICw/ZgVWFHR1+4MeM6ECwF144HFbiSCfjeCTGvStI/tK6InVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=quicksendemail77.com; dkim=pass (2048-bit key; secure) header.d=quicksendemail77.com header.i=@quicksendemail77.com header.a=rsa-sha256 header.s=202407 header.b=go29S0q8; dkim-atps=neutral; spf=pass (client-ip=85.239.33.245; helo=mail.quicksendemail77.com; envelope-from=info@quicksendemail77.com; receiver=lists.ozlabs.org) smtp.mailfrom=quicksendemail77.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=quicksendemail77.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=quicksendemail77.com header.i=@quicksendemail77.com header.a=rsa-sha256 header.s=202407 header.b=go29S0q8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=quicksendemail77.com (client-ip=85.239.33.245; helo=mail.quicksendemail77.com; envelope-from=info@quicksendemail77.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 465 seconds by postgrey-1.37 at boromir; Mon, 23 Sep 2024 11:53:34 AEST
Received: from mail.quicksendemail77.com (mail.quicksendemail77.com [85.239.33.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBmHL6sGyz2y72
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 11:53:34 +1000 (AEST)
Received: from quicksendemail77.com (unknown [172.245.243.31])
	by mail.quicksendemail77.com (Postfix) with ESMTPSA id 38C6610124AB
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 01:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.quicksendemail77.com 38C6610124AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=quicksendemail77.com; s=202407; t=1727055941;
	bh=bm9PIK55L9vBacxqG1qfVzWmU1tHqOu+50gbZGZIxRE=;
	h=Reply-To:From:To:Subject:Date:From;
	b=go29S0q8quSwsa5u8D6j99VPNPE/A+8TBr614ffnapkyKy7WL6LB3dI66WYbpAMHO
	 ZHaJ8RqyYWQj7T4lYps/pfa4sYdD1T7Vo78tSzdJUDP+JVuYs2V+HskGJIvMa+2seU
	 qOMLrdnIVc9Ey5F5VYQ7qN/GMNbGp8d+tj21YNcEJZOCKX/PnjRRnlPe4ojiLMWwts
	 WRKUPRBvlyswkvlPka8rdbltl+DWHE30EOd745423o2BF5s5b0iQiOLG4MKGKVFEho
	 RcuLnDTu4X+77BBdId92tzGLQpQm5J1kilTLul7oCH1MJAltgtPO6QIcRXwMgO1YPm
	 s18JxKT73h0UA==
To: linux-erofs@lists.ozlabs.org
Subject: New Order
Date: 22 Sep 2024 16:45:40 -0900
Message-ID: <20240922164540.3962D0ADC0E60969@quicksendemail77.com>
MIME-Version: 1.0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (mail.quicksendemail77.com [0.0.0.0]); Mon, 23 Sep 2024 01:45:41 +0000 (UTC)
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
From: Elena Santiago via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: info@declodgroup.com
Cc: Elena Santiago <info@quicksendemail77.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<body style=3D"MARGIN: 0.5em">
<P>Dear&nbsp;Supplier.</P>
<P>We would like to make a purchase from you, send us your recent catalog.<=
/P>
<P>Looking forward to hearing from you,</P>
<P><STRONG>Elena Santiago<BR>Purchasing and Quality Manager<BR>DECLOD GROUP=
 SRL<BR>Parque Empresarial V&iacute;a<BR>Norte C. Quintanavides,<BR>21, Bui=
lding 5, 28050 Madrid</STRONG></P></BODY></HTML>
