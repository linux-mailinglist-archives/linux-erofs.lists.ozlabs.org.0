Return-Path: <linux-erofs+bounces-1170-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA37BCEB14
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Oct 2025 00:27:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ck1Zx3TJ6z2xgp;
	Sat, 11 Oct 2025 09:27:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.69.209.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760135257;
	cv=none; b=UXpf+jsgAtj05jKrL85bS4HWyDUKUSxjAModK7h94MYon4TYcRXoD5QKUCcT8SfcFjZa+7IFOfCXzHIcPAZjUJO3nBDEGyj6DakA0jwPSW41OW+FttFVfU3kxxyyZfMQ/CgutIR6eagvQUBnonyrr7imGHMdLMF2c9Pg08cn60Fum4KtxmT+8SG9k/ENGXGzjxoy4L7i/HexCGd9ShRTdT+bbYzyp6ojcbIKprF0uOmiAjqw57peNXo2FRW5Kt4GFd/19ZuHMEwLCEMVvZVxVtvaVv+S9+Y4yFX3Yt78CVRWY+p3+nFHkk1Um3cZW+lyPJ7BdQo2AzglfX8Un3AL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760135257; c=relaxed/relaxed;
	bh=gG0sw3MohoCNhEn8Cps79rQWVfYhE5W6XH0G6zYUGqY=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=jfmlGnoAnZ3LIhcFQeJn8GJndrS3w4EFzHViX62ddri8zICUr0EP8taIjQ9DsL1ANYpRXZY5JNMHY+4K0EvhYQ3+WJhvG6QtK4oHkZ3R87eY48IXB9dCHfDJgDgfGEKKXEKJI2fRpQ4a9S+wHbXMNKroKYwpP/z5rd0kFWR5TmQCX07jqlWlG4MzgZZpP7n+kpJF1px2wzz50CwEC758M/Hpt4PUoDj+aa7VB/gwisb2W8jSRQwjIDmHHQ9I0/ijEQwQoUul/hT/xg01PwFywTlbozJhcieu3PVtgIKnYeh1NV/eDHQbeExPg4UEix4M9MdroX56sCArCcSkmp9RIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; dkim=pass (2048-bit key; unprotected) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.a=rsa-sha256 header.s=s2 header.b=J/I4YjeG; dkim-atps=neutral; spf=pass (client-ip=203.69.209.163; helo=cmsr-t-4.hinet.net; envelope-from=linux-erofs@ms29.hinet.net; receiver=lists.ozlabs.org) smtp.mailfrom=ms29.hinet.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.a=rsa-sha256 header.s=s2 header.b=J/I4YjeG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ms29.hinet.net (client-ip=203.69.209.163; helo=cmsr-t-4.hinet.net; envelope-from=linux-erofs@ms29.hinet.net; receiver=lists.ozlabs.org)
Received: from cmsr-t-4.hinet.net (cmsr-t-4.hinet.net [203.69.209.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ck1Zw278mz2xK5
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Oct 2025 09:27:35 +1100 (AEDT)
Received: from cmsr1.hinet.net ([10.199.216.80])
	by cmsr-t-4.hinet.net (8.15.2/8.15.2) with ESMTPS id 59AMRWWm764821
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Oct 2025 06:27:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1760135252; bh=gG0sw3MohoCNhEn8Cps79rQWVfYhE5W6XH0G6zYUGqY=;
	h=From:To:Subject:Date;
	b=J/I4YjeGUlvoDsikn3qqpUTviebpZlUa5Yjnpl22lbgd4u3WCfn+GgfA2y6joTsFu
	 RhYk/2vi117gvddYx2RhasOM7oGdi6FE2ezc9bEM4HJhs4rtAuVJC4d4q69aJzP+Y2
	 5c2PwwTSMbxb6itywSuRXRGZfUP4TmC4qmwahBQMIwajJ48rFU98pA1YBi3cdIBSxt
	 8ad5/q63tPx6TG3CIV8Bpo1OBSJ64xpQUrKZnarXEJAGjS+EQf+ze+ukfW7GxVdAog
	 XsvUayVvu9TqC577Sekab556D0jXFmSowwivc2qfjwNrWGiHGAFbBKgKDNHWGhnotv
	 pFfPLNWYP21Ug==
Received: from [127.0.0.1] (111-242-106-67.dynamic-ip.hinet.net [111.242.106.67])
	by cmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 59AMLpcp323370
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Oct 2025 06:27:27 +0800
From: Mayer and Prohaska <Linux-erofs@ms29.hinet.net>
To: linux-erofs@lists.ozlabs.org
Reply-To: Procurement <mr00@usa.com>
Subject: =?UTF-8?B?TFBPIDI3NDA5IFNhdHVyZGF5LCBPY3RvYmVyIDExLCAyMDI1IGF0IDEyOjI3OjE2IEFN?=
Message-ID: <fc906049-9188-b327-c44b-7e3c7ef2e15f@ms29.hinet.net>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Oct 2025 22:27:21 +0000
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
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=XoZZOkF9 c=1 sm=1 tr=0 ts=68e98854
	a=mTt8qab5xmrgNMrDnx4m1w==:117 a=lmFmFWn-aroA:10 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10 a=x7bEGLp0ZPQA:10 a=dFwqHLXSQQoT74FyTesA:9
	a=QEXdDO2ut3YA:10 a=zY0JdQc1-4EAyPf5TuXT:22
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
	FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Dear Linux-erofs,

I hope this email finds you well. I am interested in obtaining more =
information about the following attached products:

Could you please provide me with details such as price, availability, =
specifications, and any applicable promotions? Additionally, I would =
appreciate information regarding shipping options and the estimated =
delivery time.

You can reach us on WhatsApp at +15043731130.

Thank you for your assistance. I look forward to your prompt response.

Best regards,

Wade Hickle
Head of Procurement

