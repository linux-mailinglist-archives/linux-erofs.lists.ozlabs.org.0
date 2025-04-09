Return-Path: <linux-erofs+bounces-167-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37086A82473
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 14:13:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXhgK5cVrz2yTQ;
	Wed,  9 Apr 2025 22:13:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=65.254.253.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744200813;
	cv=none; b=bygjIc1TWVcWYdLBm1oRUbC7f26Qw3ELYwy5W3wBl0WeSu9eX0vFNqwBC0JKdg7sLrqzC79wd02nSmQDViC7uNOtp1XPCF9O64Ja/FHPeeg+6jKuuXNMzttFphrrltRybJ3gjiuFKsGTcQEDGka0olc908S3z9o5qLzqaVbNmWmSn6F2KNtNOh+d5UWdvReKQGPlIF9LSlJcF4ErArsdxjcC13uKdYxLAmm980w+xBLnJ/te2+I1qklWP45jJYvoCYS1+naxnPekNNwhvyL++mxsJhtpqVNktTTIvHDo5FPN5PiL6r247wBM0sCZG/pJuIyGdqDT9LGGX6ycqiCZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744200813; c=relaxed/relaxed;
	bh=iwJSm8lex4Gk8hNhKST1dX1VRmTPWRMknIO5jVQzVAw=;
	h=Subject:To:Date:From:Message-ID:MIME-Version:Content-Type; b=B+Ufv49YiyqQBb8jszlnJiAhfgp8dTgSxEzzjAOTKqqBjEzhJ8aHfV67ZYTO6lWs9HpOkdM5d60m7KG60AfLndMDP8gJJoTVbYum+QOBhxjwA1RESTh4dIMSJislLB7Ibg5hHmPFjfz0nNoEHgcqzD9Md4N+wdHjtaY6cu7a7guEbzS/pZiMmQnVaUVqo4xuLP+EZ7vSN0+ZBhMve+a2Ugz5SODW0ppg+S0KZNshpzLYp0A2ZXUotNCEqlZSgRjcePmdRJFgmJhsHwSh8dyLBZU6+ocM+iM2YNAtK24uvLGcqQS+EkwSYdTDqeaSbWaAywqLMOgCHPW6d+XPSxA6OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paksourcing.com.pk; dkim=pass (2048-bit key; unprotected) header.d=paksourcing.com.pk header.i=@paksourcing.com.pk header.a=rsa-sha256 header.s=dkim header.b=3qIFst4p; dkim-atps=neutral; spf=pass (client-ip=65.254.253.145; helo=walmailout03.yourhostingaccount.com; envelope-from=srs0=owpter=w3=paksourcing.com.pk=support@yourhostingaccount.com; receiver=lists.ozlabs.org) smtp.mailfrom=yourhostingaccount.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paksourcing.com.pk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paksourcing.com.pk header.i=@paksourcing.com.pk header.a=rsa-sha256 header.s=dkim header.b=3qIFst4p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=yourhostingaccount.com (client-ip=65.254.253.145; helo=walmailout03.yourhostingaccount.com; envelope-from=srs0=owpter=w3=paksourcing.com.pk=support@yourhostingaccount.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2122 seconds by postgrey-1.37 at boromir; Wed, 09 Apr 2025 22:13:30 AEST
Received: from walmailout03.yourhostingaccount.com (walmailout03.yourhostingaccount.com [65.254.253.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXhgG52y3z2ySg
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Apr 2025 22:13:30 +1000 (AEST)
Received: from mailscan04.yourhostingaccount.com ([10.1.15.4] helo=walmailscan04.yourhostingaccount.com)
	by walmailout03.yourhostingaccount.com with esmtp (Exim)
	id 1u2Tkq-0004jh-60
	for linux-erofs@lists.ozlabs.org; Wed, 09 Apr 2025 07:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=paksourcing.com.pk; s=dkim; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Reply-To:From:Date:To:Subject:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iwJSm8lex4Gk8hNhKST1dX1VRmTPWRMknIO5jVQzVAw=; b=3qIFst4pWz4vi66B1jsqfZqjZ0
	fSxZzdUtk66KfaBqfjIBel4Dl8KAODgFeYNdiFEMNVQn5dbBM6tJNevxaN9GNZOxgmM4Siv/8DBYY
	ofXQ1WCyLQnBFaK1bGbuJby2bxTLS4c+JuSGHI13JmIFsjpe/Hoy/x5Rx5ecU00/tflneST8dZLej
	lvpr34qjxS05naP8H3o0CxJXsRtKO2nQZZJv7MVopCUj49YHvf9rdF35U8TNzrYT8Gj0FcUFwDRhb
	wwoVqZXOQGTN29PE/wWUnsZ6pghz/vjMK56xn1dG84MBdcIHxPqGN+zWXS1hV4LyP/u0Ml2Z3aHX2
	Kzk3KW3A==;
Received: from [10.114.3.22] (helo=walimpout02)
	by walmailscan04.yourhostingaccount.com with esmtp (Exim)
	id 1u2Tkp-0003Q1-LS
	for linux-erofs@lists.ozlabs.org; Wed, 09 Apr 2025 07:38:03 -0400
Received: from IIS13S.nt.com ([10.3.13.2])
	by walimpout02 with 
	id aze02E00102fHYy01ze3RM; Wed, 09 Apr 2025 07:38:03 -0400
X-EN-SP-DIR: OUT
X-EN-SP-SQ: 1
Received: from IIS13S.nt.com ([127.0.0.1]) by IIS13S.nt.com with Microsoft SMTPSVC(10.0.20348.1);
	 Wed, 9 Apr 2025 07:38:00 -0400
Subject: Business funding
To: linux-erofs@lists.ozlabs.org
X-PHP-Originating-Script: 0:gdftps.php
Date: Wed, 9 Apr 2025 07:37:59 -0400
From: Kelvin Slanga <support@paksourcing.com.pk>
Reply-To: kslanga@rlbeu.com
Message-ID: <7ef61fd35084bdc5e328f58fce85f024@paksourcing.com.pk>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="b1_7ef61fd35084bdc5e328f58fce85f024"
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Apr 2025 11:38:00.0007 (UTC) FILETIME=[D8A3AD70:01DBA943]
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This is a multi-part message in MIME format.

--b1_7ef61fd35084bdc5e328f58fce85f024
Content-Type: text/plain; charset=us-ascii

Good day,

I was searching for a business associate in the business directory, and I came across your profile. Hope this email finds you well. I am Kelvin Slanga, a lawyer by profession; however, this correspondence is private. I am the financial consultant to an investor from a mineral-rich African country with a political background who wants to invest outside his country. My client had approached me with a mandate to seek a firm or reputable individual that could help him channel some funds into a profitable investment where he could get a good yield for his money.

Due to the sensitive position he holds in his country and the unstable investment environment, my client has decided not to retain any of his assets in his country. Kindly let me know your acceptance of this offer to enable me to brief you further.

Sincerely,
Kelvin Slanga


--b1_7ef61fd35084bdc5e328f58fce85f024
Content-Type: text/html; charset=us-ascii

Good day,

I was searching for a business associate in the business directory, and I came across your profile. Hope this email finds you well. I am Kelvin Slanga, a lawyer by profession; however, this correspondence is private. I am the financial consultant to an investor from a mineral-rich African country with a political background who wants to invest outside his country. My client had approached me with a mandate to seek a firm or reputable individual that could help him channel some funds into a profitable investment where he could get a good yield for his money.

Due to the sensitive position he holds in his country and the unstable investment environment, my client has decided not to retain any of his assets in his country. Kindly let me know your acceptance of this offer to enable me to brief you further.

Sincerely,
Kelvin Slanga



--b1_7ef61fd35084bdc5e328f58fce85f024--


