Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6702E9E765A
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 17:46:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4cbN4yMYz30fd
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Dec 2024 03:46:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733503583;
	cv=none; b=UX5FtfqjnxFPKHJt4Ht2wImAdD8WQ7D+NpolmGOOQOTK7g/wKJhdSXcDWsJNqgWbLrE4PwndhCZr8MdqDieLvlJI3FOk18L3La6f6Mo96d2jbvLj/WZ1QLY4zXhfNLGFIBg50wq1TYYASxY5HLAM9exv7R6gi+uzCwE59h6sIuhcf6fTSCNzrwZoo7ugWNIOmf3EvWJtFxfvX6JIoCyg6+oS7FoIf0Z0J2wRFLBlSE593c7oO1qRirBtBWNFukBcOZb2o93Jf4uOUDSQDDd8LRyjE+ThSFF42yX4PcW7ghS9UY550a7eMTxfcbM7Zs+MJsOkjeYhtAhqTg2SrgTU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733503583; c=relaxed/relaxed;
	bh=fXzUFwTHmw8wplanNmQYN3E882bghiPH9dKxQXfUav4=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=jdd5w4DJ8XUv+GRkLFxciErIL8yz9T65nxl+US49LARtCC6E/ok74pGZgb1PKipWpFG5Fpj9kTjMH4ccpjQZeFZTxEXaiuKyP0zPogJLHGERI7wXC+7mvi9bxeyfCiBp07wGyO08I+l1C24d/Jv7bWT2QdJu3v4OyRRtIWbtZMmakthtGXC0xoljoBCq9E0Pa5xwtFrc9R6oGJJDK4HZVexxhiSKZ2+UKAavktOGaEPmY7yBSLx3rNGlMDQK3RT0uDWB0z/Y0SMHl+2IXy02q2g+wyWRvnUoAKaWuA9HZjMDYJJ8Kh+vbkjTqg1fjOe/7ZQ8N4PCH3rHtBAMlXjGdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org; dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=aM8KNKhg; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=vC5vxDlu; dkim-atps=neutral; spf=pass (client-ip=202.12.124.145; helo=fout-b2-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org) smtp.mailfrom=verbum.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=aM8KNKhg;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=vC5vxDlu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=verbum.org (client-ip=202.12.124.145; helo=fout-b2-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 583 seconds by postgrey-1.37 at boromir; Sat, 07 Dec 2024 03:46:18 AEDT
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4cbG0z5sz2yQl
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Dec 2024 03:46:17 +1100 (AEDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E72F114011A
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Dec 2024 11:36:30 -0500 (EST)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Fri, 06 Dec 2024 11:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1733502990; x=1733589390; bh=fXzUFwTHmw
	8wplanNmQYN3E882bghiPH9dKxQXfUav4=; b=aM8KNKhgwMGJGGUX419Xqnz4sm
	3Fn7NGGkAL8LqmPs1+9HbqnkNnhwU4lwufnwz6qj0Fdv6G1GCwd4n4c/WLyFfYfG
	NmEd8DaTZzxnMWzsZo0khpZDvUNq0t/6+Nr5Zz85i0GSG3OlqxoMVNyhAXqMZtdm
	Vzf5SjiPGTYEJJnn2JIaWtuka4TMQw8YDnMpVMVPfDepo2+H0hu+1GEBJk/Ykgef
	TK3hPWah7a3wVBEZPN9nqLqI4XeaD/qgrMCcEVlAlD4xVSIC+ZMwkkQW60DjlV7S
	ghovRmBWehnqMCSORiUQheRVBf4Sn3ECP5Sd670/NJCpOjMlERYHtVsm73oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733502990; x=1733589390; bh=fXzUFwTHmw8wplanNmQYN3E882bghiPH9dK
	xQXfUav4=; b=vC5vxDlu9uIlnEr3A8aCLWxOSPxYrnJP859pmrHnZC3qEmyVeoo
	ZxU/ePPdHNs/s5zNeo2U+SEGJ8MZQmeOP39IK4F9hqc2pWCfuROg3gbLWknJWXUe
	pF7bkVBA8nEqXw8r1hy2qfuz8J3CZ9QQuDZUrPcvQ0Pga48lrxkZP+gES/BuWPSp
	xixUr5USX0+prh86PB1Ta6+AVJ211/2LSTLDpcZ+oV07k5E8pvc7LMqMEQpt56uZ
	4za3ESVLuJRNs4NECYNXBFezIGn1u2jA2bLkYi1ndT4+T9TQYjW6DkQKvyoQ7qvB
	XKj3YQb5vjpXyFO+GGjBv+BKkVITwrNJ8PQ==
X-ME-Sender: <xms:DShTZ1HpE68HRHmtnfzZ6i1MUD7YyjkQNoGxIHF7CDc-ZAgcx78kZw>
    <xme:DShTZ6U5uwsyFYcOs0GRA_hGpJCH1JmB1H16WK2wWCHBr4F-YQrB05pLytGztCDhV
    38S7Hy-cdKtXNqW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    fkufgtgfesthejredtredttdenucfhrhhomhepfdevohhlihhnucghrghlthgvrhhsfdcu
    oeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuggftrfgrthhtvghrnheptdetfe
    evieeuheevvdeikeffveeiveejgfehheeiteejgfeuffdtvdfgffelkeegnecuffhomhgr
    ihhnpehrvgguhhgrthdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhm
    rdhorhhgpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlihhnuhigqdgvrhhofhhssehlihhsthhsrdhoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:DihTZ3Ih_mWjCFWTq1ppoOE6YslJFQKiYp6sKsD_xkbB9-Ucjf2WNg>
    <xmx:DihTZ7EVPLW2HnrxyDLMEbCX_MMGSpePps67DPsEymJfENj2SneUuw>
    <xmx:DihTZ7UGgt-TocNEBiPzf3fBiTPlRLarfI68Jdc3sm3GRFdpFblBQw>
    <xmx:DihTZ2MVJqJsceDH_GlpXDp1XrZ6I4ligpzewGxouEKk_2nSExSg9A>
    <xmx:DihTZ8c6T8hS9LIo-nU6NSQjO4K-LiRVzYi_WEUe8I29ogl21x7ZN9vx>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E09C129C006F; Fri,  6 Dec 2024 11:36:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 06 Dec 2024 11:36:09 -0500
From: "Colin Walters" <walters@verbum.org>
To: linux-erofs@lists.ozlabs.org
Message-Id: <406ae215-0f60-4f19-9be9-122739682056@app.fastmail.com>
Subject: mounting 4k blocksize on e.g. 64k hosts
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

Hi, today in the composefs[1] project we do checksumming of a "canonicalized" EROFS (i.e. not written by mkfs.erofs currently[2]), and we hardcode a 4k blocksize today.

It came up in https://issues.redhat.com/browse/RHEL-63985 that on ppc64le (at least Fedora derivatives?) use a 64k page size by default, and erofs refuses to mount:

`erofs: (device loop0): erofs_read_superblock: blkszbits 12 isn't supported on this platform `

How hard would that be to support? If we have to start dealing with different composefs digests per architecture, things would be really messy for us. Especially given even that's not sufficient because on e.g. aarch64 nowadays in RHEL we support both 4k and 64k page size kernels.

If it's not easy to support mounting 4k in erofs regardless of host page size, I think for our use case it's probably OK in this corner case to just read the entire EROFS into memory if that helps?

[1] https://github.com/containers/composefs/
[2] https://github.com/containers/composefs/issues/335
