Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AB99C972615
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 02:13:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2kgv2t1Zz2yQL
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 10:13:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725927207;
	cv=none; b=QSBlNhgZXC7uxZrzc4m50vQ6Ab1vehkgmSG2n5xL0DspPL2jaSXFP+gLje+zpsjxnc2lytoqHUM6HEZvu7vWmOdOddecFDpHqXWsTawL6YOXL4wryWWD9kuuqoD+FJbbI8klkvWKwLz0PH7bw1zr0EQTjuBu2lwN89JkYmWluVHUX6ozhqzpj5SA6Ni5jf/okzpVPeoHmgr5nITlDUypYrDJJLZ9VpreYSua+FEFks5NanRBzDt5wzZTYZMXLZsIPegNdZdhOo5Jb+edDPcMu6Eivp0XsWSwSM9Zy6v/EKEUOhksHSUh4RnJCbtPmwFk0TTLMRQzz/ZuEbyiJZ5eUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725927207; c=relaxed/relaxed;
	bh=fKI4i4kY3uZ7tC9wpbWIKNOVsMDg+90C6y/ABOelzM0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SEU+dOMU1K1YJHwrvcOVduLioaXLkv8BnN/c4oiFvhX4+eMkY3jRHUpwPzYVqI4pU2fOSDC/WY7BoDbsLIFuzNiw5fTaHew+fprRS4s7GkF2xjSp5xZgy7rHQjIFCvkc+q/2yK01AyS9i2UmEuoPLBU8TEzxH9xgtH6lKoAZqjGBM8/Xwl2SuVZavUvReHbRauSCleX28GZyUKXE7pmf/hnonZdTDVD5vcvN/AcJtrU2G9BWOHA0ipK564a+lJfnzjw1QL8XKu+vpFSKHXIIgZwpj9E3Vzbr5+PN5EnARAxjcDVeZk2oQWNVLvTggV7LMoCk6ydRqbCZ/tm6wvbL0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org; dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=Kfijd79+; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=gFREr/gL; dkim-atps=neutral; spf=pass (client-ip=103.168.172.148; helo=fout5-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org) smtp.mailfrom=verbum.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=Kfijd79+;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=gFREr/gL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=verbum.org (client-ip=103.168.172.148; helo=fout5-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org)
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2kgm092Rz2xJK
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Sep 2024 10:13:23 +1000 (AEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9320C13801BA;
	Mon,  9 Sep 2024 20:13:20 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Mon, 09 Sep 2024 20:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725927200;
	 x=1726013600; bh=fKI4i4kY3uZ7tC9wpbWIKNOVsMDg+90C6y/ABOelzM0=; b=
	Kfijd79+HircDC18Co2EGumxNw9SH1q8waXY5i7mXe76Y9zuhqzgDHpOLMc2mMs9
	njEHv6piBimxZp0XE6Wh+KxDIHMkvFpBlsEjl08eK72YjVijCsak5TMDi64PQbRc
	HWEXb3TViEyKvW8VGHI8gWArk6Nt4glrCDGfU2Y6yresa2dE12g3zaXTDpFw0nwl
	VhT/7nFBDW4HmIxI2wNW/ZXD9nqlqtkiHlvEf7Fc2M51s12qhg1HO4FwWobGO0eN
	sp+LXUkno27npHutBO+dHcDRt7bU4V0wuTyG+3aE/zDg5XhbURCWjcg00Ngy4VcG
	tFuzdj9q9zZcrhJgRWswyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725927200; x=
	1726013600; bh=fKI4i4kY3uZ7tC9wpbWIKNOVsMDg+90C6y/ABOelzM0=; b=g
	FREr/gLpVDe/OeQOgUY6CXg+wx52oY1v8USEDCam+0F+p9AzB7jeGj7PnjKmZDKr
	VWPh39q+wDi31GKtX09RJfl46/317q42BWa6jNba3WM3AmDNthXcsiuVYy1qXhwB
	ooPUqeZbNNNMgzFiZzbYnQNlW4zQoFfjxmoJZ7qaScnsAOYupSzT6RH9A4H9DztS
	rW3tLeMtoYWv9/yKXe3afNYZrzIfwJMnpE++yCa8Jjc1eOx2R7RdsAtZiKHXODLK
	pTpoyeniMBR17u1vpf8f8NIa6aDWgcYAu3nQVfEcSe0hOgKeS+6QSoho2T3jj3+z
	EFFm1/vltS+xI4jY5oQuw==
X-ME-Sender: <xms:H4_fZgFHqSZmkZWgsaCUSMksNM1wKoWBQEFEnoyoa3gP_HYbc4aHvA>
    <xme:H4_fZpU9wCYo87Erc8MG1DoCjsi23rbVmWW7VFur8YAYEw-b6yvgB88FTlcc8J5_-
    sty22eBpoRyVBL5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevohhlihhnucghrghlthgv
    rhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuggftrfgrthhtvghrnh
    epleffgeegffffleeugeehgfejleelleejieffffetheelvdekiefgjedvudevtddtnecu
    ffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhshhirghnghhkrg
    hosehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhhinhhugidqvghr
    ohhfsheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:H4_fZqJu6ilAYQyf4EhMfhcri2fTYQjts7yyTiyk_aRlvA4oQH9oFQ>
    <xmx:H4_fZiETcjbPJhrIy5VkzL2UVlPr7ZNzSdWbb-cANx_2Dm_uZPaH3Q>
    <xmx:H4_fZmWPcSj-OnsFBco2DzBOUponvlAfRxwVzpVqml4T08VnCaxeAA>
    <xmx:H4_fZlNoMYfqhB8ZmCD2BcmgPRwPc7joInnid2_1Zrun6B6BBaC8WQ>
    <xmx:II_fZjhEF_C1ui2QikD5RXZ2oAMqLxcWJtBfwXkBKR8-t11E_-cy7ViQ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BACCA29C006F; Mon,  9 Sep 2024 20:13:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 20:12:59 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Message-Id: <7bbda10d-cf22-4a5f-be2d-6c100cf0c5ae@app.fastmail.com>
In-Reply-To: <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
 <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
 <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
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



On Mon, Sep 9, 2024, at 11:40 AM, Gao Xiang wrote:
> 
> Just my personal opinion, my understanding of rubustness
> is stability and security.
>
> But whether to check or not check this, it doesn't crash
> the kernel or deadlock or livelock, so IMHO, it's already
> rubustness.

OK, if you're telling me this is already checked elsewhere then I think we can call this end of thread.

> Actually, I think EROFS for i_size > PAGE_SIZE, it's an
> undefined or reserved behavior for now (just like CPU
> reserved bits or don't care bits), just Linux
> implementation treats it with PAGE_SIZE-1 trailing '\0',
> but using erofs dump tool you could still dump large
> symlinks.
>
> Since PATH_MAX is a system-defined constant too, currently
> Linux PATH_MAX is 4096, but how about other OSes? I've
> seen some `PATH_MAX 8192` reference but I'm not sure which
> OS uses this setting.

Famously GNU Hurd tried to avoid having a PATH_MAX at all:
https://www.gnu.org/software/hurd/community/gsoc/project_ideas/maxpath.html

But I am pretty confident in saying that Linux isn't going to try to or really be able to meaningfully change its PATH_MAX in the forseeable future.

Now we're firmly off into the weeds but since it's kind of an interesting debate: Honestly: who would *want* to ever interact with such long file paths? And I think a much better evolutionary direction is already in flight - operate in terms of directory fds with openat() etc. While it'd be logistically complicated one could imagine a variant of a Unix filesystem which hard required using openat() to access sub-domains where the paths in that sub-domain are limited to the existing PATH_MAX. I guess that kind of already exists in subvolumes/snapshots, and we're effectively enabling this with composefs too.

> But I think it's a filesystem on-disk limitation, but if
> i_size exceeds that, we return -EOPNOTSUPP or -EFSCORRUPTED?
> For this symlink case, I tend to return -EFSCORRUPTED but
> for other similar but complex cases, it could be hard to
> decide.

-EFSCORRUPTED is what XFS does at least (in xfs_inactive_symlink()).
