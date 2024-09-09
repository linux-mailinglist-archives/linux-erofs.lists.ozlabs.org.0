Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E91971D01
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 16:46:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2V692XNPz2yVF
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 00:46:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725893212;
	cv=none; b=NRFilO7oC3WRgapZyxyY9/GQeu5r6oGofvXAj/tzeEHKO6Rdr54lmwPi2JFpdI4RRGckx6jZBmLe85GlLfM8Mho+myeBLCrQVSiYbXGYeWFZRqeLFJULvynGMcaS0vEo4/Y6b42U3+x3DKvQZou3EOUzChM0rJKtvNO96//RtQpHHpdVBBQL1YPP9XrEuAAEVWiJmNQzW4Nvv5wXFhWIWQ9SkW+1eodR3pbjdYxKgmiDYBcsnrGBOI+RQR16vbhqrJVorTKYnYz0waIusz1qfXU2yBRyUFw5SSMW6zZuHwAPu0TK9/thQv3l6sHc6Cz4Ia+hVoa1Z3tOLO0xJNKNug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725893212; c=relaxed/relaxed;
	bh=i/QwEHWyOi+YdDf93y59YH6Ui41AbGHNMvvbwJyFu10=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m06f63VpoykkhCS+YbG6MbAQ8CAOc+SHX4lYw5CQZ0vtozqShnBpyRw5+EygLzHaP+ilcD3OCrdWFYZxqU/gqUhyMmkg3dH2p4X7gm2aCJTema/EvoxYy/BoGRgWbAMVrdua4ZhThv3LboIY3AGbFR8XmEtkqD3Mc8mjPgECLnYzdxaUWObFsIJlCwrmsjtndZGX+xxAEg4GOlyEmmleN0QHz6U6QFxUfWmSLCT0Zdp1uNTkw/Vb80xsIYHgCZhSNQVd4H4wvrEpwtokZLFmb2ks7Vr3+VKkQaEcD1rcC5t/vIbO+NjNhGihXJ2ZigaxDQ+7S+jZOuzB29QhCe1gCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org; dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=Xmu91i6+; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=PqVeMoTs; dkim-atps=neutral; spf=pass (client-ip=103.168.172.151; helo=fout8-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org) smtp.mailfrom=verbum.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=verbum.org header.i=@verbum.org header.a=rsa-sha256 header.s=fm1 header.b=Xmu91i6+;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=PqVeMoTs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=verbum.org (client-ip=103.168.172.151; helo=fout8-smtp.messagingengine.com; envelope-from=walters@verbum.org; receiver=lists.ozlabs.org)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2V642K9sz2xXw
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Sep 2024 00:46:52 +1000 (AEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D4E6D138024A;
	Mon,  9 Sep 2024 10:46:49 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Mon, 09 Sep 2024 10:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725893209;
	 x=1725979609; bh=i/QwEHWyOi+YdDf93y59YH6Ui41AbGHNMvvbwJyFu10=; b=
	Xmu91i6+GBq7R5vxYcsohi+FgyKyOWpzBD7ZOE5XniwWn67STOnlHGpOxqQcBBRY
	6yxDst9+CCnVwyaaaf7ZrN6Ly3b6gZFCOKvACdlpDqFsxEy3vdnDOipReT0N4lsP
	T6GdPQ+8ZmzZJN4bhH9SdcXgu2YrtxxPxTGy2RRXZl1sNr5m8IVy3F6C7u06lJXN
	12rNQAv/Km7OX6Ds5PDfknD/ZBGjlwpwsl0Hk1b4atiM39zPLKUBvOzvQ2kRTZg7
	Tz9l6tVT8rsLumZHB0nWb143veg2HDGfFvvYmkYXnAU9GtsN6OMepEkxa9bl7cmg
	TsqHOqgvjPyWTG1IRqxwCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725893209; x=
	1725979609; bh=i/QwEHWyOi+YdDf93y59YH6Ui41AbGHNMvvbwJyFu10=; b=P
	qVeMoTsMqow53PaDxz9CGuDMvPGgnnYcxqOelsyc8URFk96/zj0sG+fVp0Yb6MPx
	XrKMwaO0Ry6wHmzgKcZ1Y+jORN5c1jneR2+itvO1CPRkZuJCbeK5/j7/wu3Qs5eK
	9ALkCZ0g6aRnwiRk+Nn4VUWFWlY92y6OFDPiJQ/lXjvuTjtT+EFFaIzX0wMtT+17
	D5JYvoNMKRULUHzF0f8WX9J6lxnKN99d60U9nCpAhksWGyk+xg2Ts/NZi2ZYwI5W
	/pzLJZhFx3wuBnR5h4z6oHbh3MgGenfKQqP/Dkqv3+9P83865CCc7s7yrBknhTit
	7T+4BkE1CTcLFBhw4i21g==
X-ME-Sender: <xms:WQrfZsYT0LedlWhlgRns7ysMymwEXDOBQfafiFotwhKUC9BiERY9BA>
    <xme:WQrfZnZr2msRsHtFrEQf6h3qe_bgwYiZ2I1d6omg51VQbYMdNTZjDzf7_SGKACwWU
    JmiKYs1oRjV0iG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgieehucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:WQrfZm8dtISpRrJfTZ2vdhP6mqmPLpIUYVR7gvlTZtAxyr7fZqH2Kg>
    <xmx:WQrfZmquWfxwGccpMaqY-y-fP5RpC2jUmr7Wt6CxePfhcIdRkH1Z1Q>
    <xmx:WQrfZnpD3vZOzIzkppN0ViGf6jkT4rkbnDspOkJCXHBifFYG3Xww4A>
    <xmx:WQrfZkTzoE4bzTKLYmSvCBrbuMHE7ysMf8RK66yfhIU8dk_PJN5w_g>
    <xmx:WQrfZu2F_CEauXi6X998S_S5gFEtcT4KtIVM9YbY1ms2Ry_gf8lb7Fj6>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2742A29C006F; Mon,  9 Sep 2024 10:46:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 10:46:28 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Message-Id: <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
In-Reply-To: <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
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



On Mon, Sep 9, 2024, at 10:14 AM, Gao Xiang wrote:
>
> Not quite sure about hard limitation in EROFS
> runtime, we could define
>
> #define EROFS_SYMLINK_MAXLEN	4096

Not sure that a new define is needed versus just reusing PATH_MAX, but that's obviously just a style thing that's much more your call than mine.

> But since symlink i_size > 4096 only due to crafted
> images (and not generated by mkfs) and not crash, so
> either way (to check or not check in kernel) is okay
> to me.

Yes, but my understanding was that EROFS (in contrast to other kernel read-write filesystems which are more complicated) was aiming to be robust against potentially malicious images.

Crafted/malicious images aside, there's also the IMO obvious angle here that we should avoid crashes or worse out-of-bound read/write if there happens to be *accidental* on-disk/memory corruption and having high bit(s) flip in a symlink inode size seems like an easy one to handle. Skimming the XFS code for example it looks like it's pretty robust in this area.
