Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61AD971BE7
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 15:58:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2T2h04yKz2yRZ
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 23:58:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725890329;
	cv=none; b=PiLhwWNDmwnpupH3DdIQXh26UWHjcx6D5VYPOoOCCACpwKnA2qvzPpjoSNYU11qWIHaD6BPHjYPfJiJdaQ1nA38BGMmUxuL/0Ht47XPdinVw6B46erQLWq/0bTK/91EPIMid7d1Ib1DfOfdY/ENZbgIaQVb8Cc3ab+UzcYW0yNAiNlwCJBkIe2sB3TzB3XHrr5+mzDeu+UfkyNxN+bc7cK7yAkAc0WiF34LIthUDyN9vNnWfveKo/4hhmzFHKhQTM3Sve6LgRgeAs39eHnfG7gwFw03qolKR0/V+CgbSpxMgaG1ACHRagx03YzCr5XPXFaZ173IG6xIdn0TfCCVPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725890329; c=relaxed/relaxed;
	bh=eVRD64FOzRlp7ciLKEZlsqJYsnWp7ClsvlIqP1czsQo=;
	h=DKIM-Signature:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Message-Id:In-Reply-To:References:Subject:Content-Type; b=ldhQD/YM+IGi5IUd48F0gX5tCsxG04jvCOc10jI80xn/lFH0Htdid4rgrzPk5PZ/hzqMQL2tFE4hBKh/3YNAlxjLO1/buw1mTxUFf7cS6Sxa7/2CHW8GpstErQZEVO4SrHXEfoVqCApBh5O5ehBW741rA5bd+s+udT7XnBGqvvLOGhiIwFNoXPk213lhdVKyMSC37Dr7HcCN+UAD2qsWR+Bjq7iVc02N4yO1fpmCyLxu7jZ4fqyjOM8MDMvtkBZZmnl95iGsFDQh81DPtDRnFGxnktL21NsHKNdWBxAi6ZiUSi4Gjc5X9pf4S63cP415qAlOlx1qROoPXCbOr1DkoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org; dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=al054RjZ; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=MZdEhuMa; dkim-atps=neutral; spf=pass (client-ip=103.168.172.154; helo=fhigh3-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org) smtp.mailfrom=verbum.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=al054RjZ;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=MZdEhuMa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=verbum.org (client-ip=103.168.172.154; helo=fhigh3-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org)
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2T2b04R7z2yDM
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 23:58:46 +1000 (AEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B36801140191;
	Mon,  9 Sep 2024 09:58:43 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Mon, 09 Sep 2024 09:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725890323;
	 x=1725976723; bh=eVRD64FOzRlp7ciLKEZlsqJYsnWp7ClsvlIqP1czsQo=; b=
	al054RjZPVf6vUDNPlVxHMbhv8EAmVD/teRbBLRAO7V7xVGT2leBGBlsUQZ2SjfU
	1yAhCYLeUyoZFDznQURVByJNeYmuwmqkobAIXxaDiqkhw1gAv5SPkQRdo7pIPOYY
	lZ/NDEKS8AgvS9vI6RFV+VGUx5z6nNXT78lbLT6qR+6x/FkGhx0zWNyPBtcdWDNE
	fuGix4nac0E1/VcStiEBvBldEq3fLIC8uWyHQ3swSAfFDBRf3NsVbv0lDGlDI9FT
	jznrgRZrBzlmSWjW74ezj4cVu+AUlwHuumGZyH24eC/003jC8aOcu+veC8hqHLUH
	akGsyoCGgw9w30sp9HGKmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725890323; x=
	1725976723; bh=eVRD64FOzRlp7ciLKEZlsqJYsnWp7ClsvlIqP1czsQo=; b=M
	ZdEhuMadO3YCtpm0XmLhQa+P7I8tjLdpuJl1ocPBAZYuJLrjV8ZghUO7rCNWCTO2
	/U6Qda2K2VF1TEVOzxPY2GFd5P6tSYY2FBjgiwIZGb0cV2bjlqzgeEesYROHYCmE
	NlK1wJAV2oj6lGdqQjHajvF6yOTSBelLpJOiwSCrxJ+D7S2ftb0W8lqr5jUCZEVg
	iwZxdI49iFZ8rnGkvGedDYzBsGETPJ+y+0CJGlunJieK/b96+pEE4+3ATfe2iUYY
	qVoCv7xdAdMtzckdCc5mWg48ITgnIMgDEFxy+MJBDK42iTn2ga4ZkMYIE6yGnDGu
	FEdmsxgg+EGqe86fwwtHg==
X-ME-Sender: <xms:E__eZl99U9UhRvgHS4oh-RvIM-ZljGuungU-6Fh1Y6Lq8KyG6RSfHQ>
    <xme:E__eZpvXuRTaz4ahNT7hiKGxIxqPiLzb_wo1eaLfhphrhTT5UPxvf8fj2J4CHQ0kh
    LaDLWhbfqSBAYNt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevohhlihhnucghrghlthgv
    rhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuggftrfgrthhtvghrnh
    epteeflefhieetffdvhefgudevieejgfevueevleeuueeviefffffhvdffveefuedvnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvg
    hrshesvhgvrhgsuhhmrdhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehhshhirghnghhkrghosehlihhnuhigrdgrlhhisggrsggrrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqvghrohhfsheslhhishhtshdrohiilhgrsghs
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:E__eZjBnGu9y-epUSyny4mRIjApb0AOX0_HvAwreDeqfpTGRFvOkJA>
    <xmx:E__eZpd7Fox736CpDEq0w1NeTs5IBc0HWmtiQSEOnx6bydsZzjh7aA>
    <xmx:E__eZqMNFPYo_ZQzrChMh0tlaRiHzUMQaU9jGhnTqvFFgg8CJadiKQ>
    <xmx:E__eZrnc9DdkV7uJoWKSObwOcRaX0ugiIeo3XtlzYQPZ1BqbCgvWvw>
    <xmx:E__eZjYMaB83mPL2L9COuG4zHKf8LEYeYpAAWXOQ3A2XywmSjt2WgMPE>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2673C29C006F; Mon,  9 Sep 2024 09:58:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 09:58:16 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Message-Id: <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
In-Reply-To: <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On Mon, Sep 9, 2024, at 9:21 AM, Gao Xiang wrote:
> 
> It can be bigger.
>
> Like ext4, EROFS supports PAGE_SIZE symlink via page_get_link()
> (non-fastsymlink cases), but mostly consider this as 4KiB though
> regardless of on-disk block sizes.

But symlink targets can't be bigger than PATH_MAX which has always been 4KiB right? (Does Linux support systems with sub-4KiB pages?)

I guess let me ask it a different way: Since we're removing a sanity check here I just want to be sure that the constraints are still handled.

Hmm, skimming through the vfs code from vfs_readlink() I'm not seeing anything constraining the userspace buffer length which seems surprising.

Ah interesting, XFS has 
#define XFS_SYMLINK_MAXLEN	1024
and always constrains even its kmalloc invocation to that.


