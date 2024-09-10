Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84F974453
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 22:52:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3G9D5WqLz2ydG
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 06:52:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726001531;
	cv=none; b=Y+E/1x19cRDKBbMO5XteJM0/FoBUYC0tDXBihp5H7fnmFEbZsprt8GDryArhPBQUmQB2NHo8CotwWuKbRsjitbEeC0f11/E6sT1AsPXtDTY6ZxvAlR+O/lOMJRcF3nph2iUoJl1OjunwycqylFaeqv4rJ/c4w2bcHvWnG2wXBTa87WYJZHcsvVxveUMRd7zK5tHkFuSQbmIUA52+ZQEAxeA2xIiCotnW6FZzs0gkVON7z17zw+c0Ud6rDeffJftv/SHyJPIB+bfiv7oNtB9m1GKur2Zax4Pf2OGbDARVDU71YooLsO0AlxXywHTNxvqgXHAiETCDCTr9ibRIY5xm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726001531; c=relaxed/relaxed;
	bh=GXC0yulCrynQrY5/3EoWZXN2eEiW8kN3wl0FVcVuFxk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EGzcsWoCxM/NIrXJnj1q9yWNKXy257Y7szMg6a+L/mDZrCnLXqoC7x3UjHdRO+lFCDUr8PKDyqZP6a5w09tL7YOclDq1Fp2fnXB0PE3JBxRJ7Ep2J4FmZMwMTHLlYoje7EN998gtxeEEdq7cBxmgxh9CCScCd7GmqEUc6yU5MQIiacDK7iIDF2EPtDJ9+yQr6C4tRQnYDW6mkkI9o2E4xcbqnia/3hUM2aAAT82EZcs30zUCYMYgwNt8gFVQMBZQGtUnziK3bvK4C7/GRICL7CRRSvSZrpa6S15yvIbTV88hKTfYLa7l9QfySvY14IpMN6ntfGX+Tt8dDe8ubT0W0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org; dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=ENSMjzN1; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=Y9vRvNoi; dkim-atps=neutral; spf=pass (client-ip=103.168.172.157; helo=fhigh6-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org) smtp.mailfrom=verbum.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=ENSMjzN1;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=Y9vRvNoi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=verbum.org (client-ip=103.168.172.157; helo=fhigh6-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org)
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3G940nrzz2xdR
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 06:52:06 +1000 (AEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 858FB114012D;
	Tue, 10 Sep 2024 16:52:03 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Tue, 10 Sep 2024 16:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726001523;
	 x=1726087923; bh=GXC0yulCrynQrY5/3EoWZXN2eEiW8kN3wl0FVcVuFxk=; b=
	ENSMjzN1H3C2E7LkjrJ4FO+OiSYzYKdzVdM7d4zjr7aCsGmgBh1IisWNBFGbdu5g
	dsGAxYNXOnbsiNlXxmfNdZG3GS5/Ia15wme3nYdeFit0aQ4uMplA0syxnWJJZdFH
	0W9GzmTF2cw4uoIl58EfzFTXLTNqtdzSvsjKxZ12hMOQix6qVjqvYKupb8wnEsVK
	x9m9RPX5mFqTut2+qO44Uy2LyS0ihioMAfxQC1wQf//VWxlnKaSbVehpXBYpskMA
	iYBMJqs+3yMuZ6xdkxMVjULYmuZclZQXj3j4NiwC0YXC7PC3yhfF0rIetHHefzPL
	THaDu58vB0TpIxvH/+ee2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726001523; x=
	1726087923; bh=GXC0yulCrynQrY5/3EoWZXN2eEiW8kN3wl0FVcVuFxk=; b=Y
	9vRvNoiGGtX3B6MZE/tIVNFPRe7j+wQwWyvIz1jFeXk5UaJ3+2IlXfDBAfo+PnWo
	VDKUrevLx3fPov5HfQiWhvgLJBBJK/46rfK/JS1K7BmD07IHNA2J0vNskDRYf6Us
	0BImkw87K56M+h9mwHmWKlUFBpH9hiZpvtFb5gVo0ucFwY5IIW7qLj9pK6eD8zIc
	yfz+Z9rLctvZE/SdAll6egGrJMMAAGhxWXeQ/eOZiuicwcuU0yIowJkDYnZVkqNe
	2zryq566mBHorlualrt5Krv+bb2lfewC3GT9WTep+NvlWnSGfpK9J+CvFyhXNBL0
	mlN/y3LPey1fQ2q6lsIJw==
X-ME-Sender: <xms:crHgZvtHPlAxZCVhdvN5h5_npGzd4l_DmguXqPGKnrxQP01qvYpECg>
    <xme:crHgZgdEimwSU0tqAW_8FIcZB53S4bIaO_Bj_vmujXzfKzcWZ_Z0gHQirjrk1gvfL
    9-0QALKCNmGmztZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhinhcuhggrlhht
    vghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtffrrghtthgvrh
    hnpeefjeeitdekueejkeekgfduffduiefftdfhkeevuddtudfhudefhefgfeeifeelvden
    ucffohhmrghinhepfihikhhiphgvughirgdrohhrghdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghr
    shesvhgvrhgsuhhmrdhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehhshhirghnghhkrghosehlihhnuhigrdgrlhhisggrsggrrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqvghrohhfsheslhhishhtshdrohiilhgrsghsrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:crHgZiyZ0S-deCU5qyGaequ85oldZaAxmJuYkuUgZQQVSpU0Mt4elg>
    <xmx:crHgZuMrT01nDD6v9b28yisSgfgqNHE0wTFWswXAAlA1T7l9JTkmaw>
    <xmx:crHgZv9lq5ejeaivPQuyIyGitt9WL_T_mayqH2I9792v-EbbheIpmQ>
    <xmx:crHgZuUjmDvfokWAEgtxOCnXPejVuXTS_pS4yTcNSiWlo3yEEDriLA>
    <xmx:c7HgZhKUF93rh_Kvr14wwFfYrmGhGwVZ_tq7bE8A0Nx6Jvn5U7MmBmtF>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9DBEA29C0072; Tue, 10 Sep 2024 16:52:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 16:51:41 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Message-Id: <ba83ef6e-d4cc-4ade-9dd0-e3fdfa8fde70@app.fastmail.com>
In-Reply-To: <e137404e-16cd-4d81-9047-2973afb4690b@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
 <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
 <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
 <7bbda10d-cf22-4a5f-be2d-6c100cf0c5ae@app.fastmail.com>
 <e137404e-16cd-4d81-9047-2973afb4690b@linux.alibaba.com>
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



On Mon, Sep 9, 2024, at 10:18 PM, Gao Xiang wrote:

> I know you ask for an explicit check on symlink i_size, but
> I've explained the current kernel behavior:
>    - For symlink i_size < PAGE_SIZE (always >= 4096 on Linux),
>      it behaves normally for EROFS Linux implementation;
>
>    - For symlink i_size >= PAGE_SIZE, EROFS Linux
>      implementation will mark '\0' at PAGE_SIZE - 1 in
>      page_get_link() -> nd_terminate_link() so the behavior is also
>      deterministic and not harmful to the system stability and security;

Got it, OK.

> In other words, currently i_size >= PAGE_SIZE is an undefined behavior
> but Linux just truncates the link path.

I think where we had a miscommunication is that when I see "undefined behavior" I thought you were using the formal term: https://en.wikipedia.org/wiki/Undefined_behavior

The term for what you're talking about in my experience is usually "unspecified behavior" or "implementation defined behavior" which (assuming a reasonable implementor) would include silent truncation or an explicit error, but *not* walking off the end of a buffer and writing to arbitrary other kernel memory etc.

(Hmm really given the widespread use of nd_terminate_link I guess this is kind of more of a "Linux convention" than just an EROFS one, with XFS as a notable exception?)

> For this case, to be clear I'm totally fine with the limitation,
> but I need to decide whether I should make "EROFS_SYMLINK_MAXLEN"
> as 4095 or "EROFS_SYMLINK_MAXLEN" as 4096 but also accepts
> `link[4095] == '\0'`.

Mmmm...I think PATH_MAX is conventionally taken to include the NUL; yeah see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/namei.c?id=b40c8e7a033ff2cafd33adbe50e2a516f88fa223#n123
