Return-Path: <linux-erofs+bounces-1701-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A3231CFE40B
	for <lists+linux-erofs@lfdr.de>; Wed, 07 Jan 2026 15:21:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmVZb74mgz2xbQ;
	Thu, 08 Jan 2026 01:21:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767795671;
	cv=none; b=gFPDCXmP8Oc5hB/Ku8T0+aeUtdxnFv8aDKdKfQDcIwsZnuTIZudPDKMQKqhZxUrsIhJ7/R0BmFejkUzZivYuwsMyQFgqUhnWdD8mgJEhp0aZP4GPdIjfcFfIs8ZyAvf7kxI8H04evmINNQjiJ0lMfLqdhDEne2kshnMTw0UW9TbgYJr6GVWYQQJWEgpSGM0z3bu81U7dYVTR+sbuIgk2EjM8NZ7WOMzRxiQvHD8zKCPa6OotPDdGbmBcoKOpdL4jZ4bvvn7H6Ugr4atFCMP3LAy4ZfRjzEov01Lh65S5sxP9dRkBrGO2jFFMKxSWbZqGJVZDGVcLIL9ObVGlCBn/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767795671; c=relaxed/relaxed;
	bh=dOKD9JMTnRtbOxhVDcnF3A5ak+ih4nA3hWhXQ0/WKc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pe+u+zwQ9+hDFn6x5MHQrNUf+CBbrhwevuMT7CDkILdYaJ0bKq4KDK0i7qxKm+BK9cZiG64l7fbVZu66CEV/EDz6pz2/3uU8hkHU4HeTYH0ytMoFxlZknKC0A/NVPWycoYUdsK0fnCM5zRvvWSPlKjmvRF79VAYnP8WSNxUaxGDLTsDAM2xfpt6RJxPJJgGA430shCJ5HyJ+S+v5Xepe13RuijTjLJAUhr/NBkV1NkJJt5UHXcMqvTmHoj0NizKLowHMJGZ7MQPPmtCW21SSisuoP+IW+GuVdIx3YiL2L2g55id046taa8WnbE2L1MvXCEomC3LFQmHQmn3zFXt9bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dustymabe.com; dkim=pass (2048-bit key; unprotected) header.d=dustymabe.com header.i=@dustymabe.com header.a=rsa-sha256 header.s=fm3 header.b=z/GaYuPU; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pVx+QKPX; dkim-atps=neutral; spf=pass (client-ip=103.168.172.145; helo=fout-a2-smtp.messagingengine.com; envelope-from=dusty@dustymabe.com; receiver=lists.ozlabs.org) smtp.mailfrom=dustymabe.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dustymabe.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dustymabe.com header.i=@dustymabe.com header.a=rsa-sha256 header.s=fm3 header.b=z/GaYuPU;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pVx+QKPX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=dustymabe.com (client-ip=103.168.172.145; helo=fout-a2-smtp.messagingengine.com; envelope-from=dusty@dustymabe.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 593 seconds by postgrey-1.37 at boromir; Thu, 08 Jan 2026 01:21:08 AEDT
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmVZX731sz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 01:21:08 +1100 (AEDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 600D7EC008C;
	Wed,  7 Jan 2026 09:11:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 09:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1767795072; x=1767881472; bh=dOKD9JMTnRtbOxhVDcnF3A5ak+ih4nA3
	hWhXQ0/WKc4=; b=z/GaYuPU3WkHTw6BIu8x4ibkRiKb+Bs8z7PuJcMVCM1uqJ2G
	kLbqEceqAlV0FVbnLH1ZG9WO3Y6rOROZI5lk2pXPyZuG+99T0ZrUFOAGk/Mrmd+p
	0hE6buJUtaTtxM9AgR1ur40ZB/zndqBkCcXcy38ynQh/GJCAmLxRSflWQOp1PGhs
	6P91rQwKp0+Q89cXrRlfhOzAoQ7NLywpUeAiWI/0ym2JqapyfexGjeG9plGqBQgz
	+qLFAbUU8BHtoxs+HUsGzeeP/4duSeB2ExtMIBAI7eC6WM733o5FuzNvOvwTpqv9
	SbArT31ibYXzCG5mUeptju1QXZLQBNGBQO5Mwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767795072; x=
	1767881472; bh=dOKD9JMTnRtbOxhVDcnF3A5ak+ih4nA3hWhXQ0/WKc4=; b=p
	Vx+QKPXnKQeYDYlFo3HgeFCT1BTr05iIAPBHxr1xJgq1MyAv7u7naSC2HLEpNhfj
	FZ7Lf0i5iYcp+T6sHM1kLyG2hdLTQ/lPk3yex8vlupQ4HN/T3FzB0rxY3EXXNLgR
	LP7gndJSqXSGGZuCQq4ePr5aNggckzUKImOPCaqdx2n8wfKROD7DkTevxJ6lo3R2
	l6+Dktr2glc2EzNg0tGk/9kGvdfilF4CMbI5tjzYV0QMl14IvH5Qr9r9aTvRuyZ3
	rsJQXr8/ZP/GfDAWFQix37eL/xs7uFDVa1FKN2oJFTjsoG/OQHOp8qZjiLOenXrA
	MMDjLlrmLdQDrQhfSxpCA==
X-ME-Sender: <xms:f2leaRsG3FVO-zEVMkl0Owquz7WO907OZGLvKVE8cg2xbxuhfsAQ_w>
    <xme:f2leaQ1aeZldWdlQF92Tmyx1S5vjXFljhQH4etm-uibK7npZ1hu5QIOZNluvl3ICa
    g4DzPLOt-BfYwKTu0wrx2XSHcegEnoZrDKgXFNwxcFrNlLk38pgew>
X-ME-Received: <xmr:f2leaRAnfyZJqeyqKQV6nQWLI5pSqeeHuye847KKDUvCrHFqd6dEXQVcmbjP4g7P7nSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeffuhhsthih
    ucforggsvgcuoeguuhhsthihseguuhhsthihmhgrsggvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetjedvueevfeehhfeuteeufedukeeugeethfetueekfeehfedvieevtdeffeei
    vdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguuhhsthihsegu
    uhhsthihmhgrsggvrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohephhhsihgrnhhgkhgroheslhhinhhugidrrghlihgsrggsrgdr
    tghomhdprhgtphhtthhopehlihhnuhigqdgvrhhofhhssehlihhsthhsrdhoiihlrggssh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepthhimhesshhiohhsmhdrfhhrpdhrtghpthhtohep
    rghnseguihhgihhtrghlthhiuggvrdhiohdprhgtphhtthhopegrmhhirhejfehilhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrlhgvgihlsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f2leaWChaemY0tI97gN2-LLQzg4NKU3LbpHqqjTQOEShedrroJYhzg>
    <xmx:f2leaakAYOb2RaUnDhYspT7rVTzSbXKmfuo2_QnqV6Zx2-PxnEZw0w>
    <xmx:f2leaehp7o57w-PD3ZZDEy0wlF0O6ZJKWbfCW6lZEuxRJ4Jdw1zanA>
    <xmx:f2leachqd1pQOnYWzlVpLdPlztvUJEJ1oxb0X2yBhEXFzv3YZmHuEQ>
    <xmx:gGleaUXaqskCkLBRAtRikoNbx18my_IQhGQiiBF-vCBHVADA3IvS38_E>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 09:11:10 -0500 (EST)
Message-ID: <6b5047ca-b6f5-4959-80d0-227f735f61dc@dustymabe.com>
Date: Wed, 7 Jan 2026 09:11:10 -0500
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for
 now
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Timoth=C3=A9e_Ravi?=
 =?UTF-8?Q?er?= <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?=
 <an@digitaltide.io>, Amir Goldstein <amir73il@gmail.com>,
 Alexander Larsson <alexl@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>,
 Sheng Yong <shengyong1@xiaomi.com>, Zhiguo Niu <niuzhiguo84@gmail.com>
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 1/6/26 12:05 PM, Gao Xiang wrote:
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> stack overflow when stacking an unlimited number of EROFS on top of
> each other.
> 
> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> (and such setups are already used in production for quite a long time).
> 
> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> from 2 to 3, but proving that this is safe in general is a high bar.
> 
> After a long discussion on GitHub issues [1] about possible solutions,
> one conclusion is that there is no need to support nesting file-backed
> EROFS mounts on stacked filesystems, because there is always the option
> to use loopback devices as a fallback.
> 
> As a quick fix for the composefs regression for this cycle, instead of
> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> nesting file-backed EROFS over EROFS and over filesystems with
> `s_stack_depth` > 0.
> 
> This works for all known file-backed mount use cases (composefs,
> containerd, and Android APEX for some Android vendors), and the fix is
> self-contained.
> 
> Essentially, we are allowing one extra unaccounted fs stacking level of
> EROFS below stacking filesystems, but EROFS can only be used in the read
> path (i.e. overlayfs lower layers), which typically has much lower stack
> usage than the write path.
> 
> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
> stack usage analysis or using alternative approaches, such as splitting
> the `s_stack_depth` limitation according to different combinations of
> stacking.
> 
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
> Reported-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timothée Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>



Tested-by: Dusty Mabe <dusty@dustymabe.com>

I tested this fixed the problem we observed in our Fedora CoreOS CI documented over in
https://github.com/coreos/fedora-coreos-tracker/issues/2087

