Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498989E79DD
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 21:11:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4j7g6jQWz30fW
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Dec 2024 07:11:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733515869;
	cv=none; b=GX+lX4fSyC+hAFxLEWTADOOQf9ew3U19mzU+Sn9m60FgDPDvLkMSCg/twU9BUvAc07yCY4FySt0Sd8vHDSqUQN20cDLmTbiF9OxuZw7NrHAGiEr8OILt3a34kZ/Mc4lSYpNlyOJ7L5Jxn69JrTFZp9gr2sMe/YPFJFr/EDHlwO5s9TpAdJ5EVjYN+4tlmatLYH+3sUTx9d+osXXqLWkqGxwygS3AQaUN/Krs+9SF5H/Y1/vkjHd52PeefaJ7XiuAMAe3b9SJwqTPFKgCvXwuAepvYUOFjfQP9xLYz0TLt61l5hwiswNBFHzZIs3YlfSBGg158Ac+hOrzhTxqqXdUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733515869; c=relaxed/relaxed;
	bh=1K/21ZIC4j6vjCwOfLkK8jcq7MeVBckc1YHVJfcTTAQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Hju6LYi5afoEeuzknPInpY/ob9RkHzsuuTFr0p1eMcrY8FsRzISB/O4tXGNLdboD0HrdAEIMekoZ2BlENV8TQXaSH6+Yen/+wymAMZJWsdQZeg6A+3u0yYZ8NMl9Od24K/LpG74fNDLe3MkjsZ4s+k1EEWjnjIYQzCTwwOaL9xLYJpc4p3yqmfOXCEbMlwsjfKqZqSYW7Y9XKJjBVbkMLV9dJQGzbhsAmeVyZiRt+/Yy3IIKop6njSnCdbrm9Y7zxF1xR+YR4gHe8c9puWcn39wTUNkmXrPCl5ss2Lz+kmuXH1uHvd3yE+jNIJy3s+q7faeyrZYj5WLFj9J9FATCjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org; dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=G2WqlMjM; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=nWmnDl5o; dkim-atps=neutral; spf=pass (client-ip=202.12.124.147; helo=fout-b4-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org) smtp.mailfrom=verbum.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=G2WqlMjM;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=nWmnDl5o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=verbum.org (client-ip=202.12.124.147; helo=fout-b4-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org)
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4j7T4npxz2yHT
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Dec 2024 07:11:00 +1100 (AEDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AA7D114010B;
	Fri,  6 Dec 2024 15:10:58 -0500 (EST)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Fri, 06 Dec 2024 15:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733515858;
	 x=1733602258; bh=1K/21ZIC4j6vjCwOfLkK8jcq7MeVBckc1YHVJfcTTAQ=; b=
	G2WqlMjM+tvfAyqx4muqV9ZikBAXHkzX6uF/cLczbhdAJuxsoH3Hn3m4H0wbBAJZ
	rwtEDWo4XRgb4VUN7G3vm7nUmt+dX59mLGqHIOCINd0rHf1DtXElyqhhtOz42GcV
	tlTGHqDG8JMFzSybMVYaA7zExfJWdOd/75tZn6arput8A5Mp501zgvsA7X7iE//T
	FbxRiCiBU5Wpf1JT1d3wf0OWqOjGLTaAdFaK7oxNxHmjeRusvGfjomqoKpcDMATF
	wQbA4RNqZ6o3KHldAQP6x5e8Dp4Da3HIqzOcTplBazZy2S2Nbd31LhAuIJJZLdW1
	CVq8/q8f6ticklhmBGM0MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733515858; x=1733602258; bh=1
	K/21ZIC4j6vjCwOfLkK8jcq7MeVBckc1YHVJfcTTAQ=; b=nWmnDl5ohGVR4AEaV
	en6NtqpUIUDpUPeO9FggCg4JHrjCWb54NHmzCHP6cGXsb4RDSieG4C8dq38wSoD9
	yQ38BdGrQD6f7l7CtsOtXxYMXK20h6oKhlYb+emGGV0RL7knwJCAO+MYBquEe8QI
	kr/wZUVJws4j+ynqP4hg9/IxWqfJyveuCs13FrLfPtCm9H7f3kYbJGTb1z3XKfFm
	Zt12a4k8qfpixqooNM3bgQLViSjv8qG9dqOFJyT9lll8erSQHhw4uwnoyRyxPKSg
	ebTEAftIKTXITRGqtrmlNBqY7cxnW1hBase4JNdoItlcnzrTJFku7V9AuX0G1dp/
	OygHA==
X-ME-Sender: <xms:UVpTZ8cXxMax3LmqimIuSCZl4X-TcQlHNRhMTgzb832FPRHEc_NsfQ>
    <xme:UVpTZ-MFRZStpfWfCQ5RQ2ASGm7y8UjGHCLWA_eafGnJnVSwyz67Bx2Oz4yfqYUT4
    S-9R0tvBOtrzpnp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhinhcuhggrlhhtvghr
    shdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ejfedtvdegvdevueffgfeileeuteevffegjefgkeffvedutdejleffhedvueekgeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhshhirghngh
    hkrghosehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    vghrohhfsheslhhishhtshdrohiilhgrsghsrdhorhhg
X-ME-Proxy: <xmx:UVpTZ9jLUWPGnIDzrkYHJ65oxta8PfoRDewNJbAChtf8MXUsJG7hYg>
    <xmx:UVpTZx9H-0assWD7Zq_E9YwOsESSTX-XwK2I6yfybJSQU79CqmB6jw>
    <xmx:UVpTZ4vmuqlbMMsVNuRgPpoVcHPKENBPS80GwjX7currSGMEw2ZAcw>
    <xmx:UVpTZ4Gnv8JbGNOEyQidM4iMt02vjMyUeklnGUDb6rHsQti9QULKyA>
    <xmx:UlpTZ1V3YtsgVYTNb1QidYPFOUOHqM78yGRjk_938Q6JmLGlIDnPNq3V>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 57BA529C006F; Fri,  6 Dec 2024 15:10:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 15:10:36 -0500
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Message-Id: <55ea18fb-7309-4328-a2f9-bebb5db61e87@app.fastmail.com>
In-Reply-To: <17b4f35e-a365-4460-b2a4-9da660ae3e95@linux.alibaba.com>
References: <406ae215-0f60-4f19-9be9-122739682056@app.fastmail.com>
 <17b4f35e-a365-4460-b2a4-9da660ae3e95@linux.alibaba.com>
Subject: Re: mounting 4k blocksize on e.g. 64k hosts
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.0
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Dec 6, 2024, at 2:46 PM, Gao Xiang wrote:

> Did you try upstream kernels? It's already supported upstream
> since Linux 6.4.

Sorry, my bad. (It should have occurred to me to check, but this one popped back up on my radar when I'm trying to do several other things at the same time).

Anyways looks like the fix specifically was https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3c4bdcc756e60b95365c66ff58844ce75d1c8f8 ?

> I think RHEL 9 is lacking of many features.

Yes, but I'll try to argue for refresh for 9.6. Thanks!
(Just tried to cherry pick that one myself, some conflicts but looks tractable)

