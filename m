Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51328A32158
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 09:38:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739349506;
	bh=/oK2sPv4LMCXJy8yVS147MvhejzIS3HvMFZ7xWU0RsY=;
	h=To:Subject:In-Reply-To:References:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jd0jQBo19A6ssXd3WH1ZAVRbdYLbYdhbJcgt/YBcDw/rBa+G0m6TueYAd4Mxs1UML
	 h5zdEvBp6Lzgm+YcuiIDQf2re6qGzvgAvHIpqTpbbrjKxeM1Y0wd8ZUxr+jShC7OP/
	 Jp5AoDNdU7Arpe5RuJkvt9FeKD+ejRAytx50k3MyFL9ImnNRlMTc80bvLkiLhtjPex
	 vnGMJnIMsrPd+1P3sZoY6ABBWEVvipmVCS8zRE4xd8Dnv5L5sFUf84EHz7FGBYDWO5
	 VkflburZULSg/mjlRZZY5P3CP7n14b6QpxxRmdIyeqhzcIa2M2CL/MHpSNAoeKxLlz
	 4cMgAqNe7y4cw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtBXy5mbvz30gC
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 19:38:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8:216:3eff:fe9d:e7b4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739349504;
	cv=none; b=a9KLbOVm+AsH8HjoAbIUErxxysuUKHjHmoJj6NigMkZVhZHs4MhIcU8RJrWoZmJom9kJzB8DWptLix2wde/8bgWxj5CCW7ZFhdeEcGu0KPKVi9AdEW4Ga4M/oVX9mJaSESz4yyojPSXDRsYy/K9CAZ4IOQAKSMSBie8bognxybTS0YAD/A9FbfVv3vW5F0YUH71zYBRveU0ORa2g8+b1PWc7nrSlgI6OAxIEWO9EJ4+KoZZ2xQU86mzMOuGGKg52SRKm344CJeg+oP6kP5nkbtqxGXRkDwJ9ltID30t+fkQyV0o6IBrNoGxmBKlJqhY/DUBFk7bDtlk6+hkWExBvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739349504; c=relaxed/relaxed;
	bh=/oK2sPv4LMCXJy8yVS147MvhejzIS3HvMFZ7xWU0RsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G+cvtWjB05xXvHK9vO4k7/y1yW/VDV+BRH2npY7VgdBFS+IyDHLWnNoqGbYUvLS2HGr196zz7TMGU7ygHM51hDwQzqD+RcDAmspGS8JQzfiANeftdwntXEQYqKr5t0+/UaI6JuxKKvYzhDMjt+eyc1CsOH3bbOpcI0HcMKDTgUmwf7gLd5VmgJPDbhnSZ25I7iXV5PzviL0KnqAINXp5/nHGlIZMNOySpf+g1LfFMGE1PuN8Dg9h1QdROHH8WIdCRQniPMzx/BLk6uE7PJ1H5xroqDijaufeX2MB5Hay8rG7I/oydjQsLxdwVrYkqQSq59U6JFSPPGz/qgKL14AFfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=bz5oivyu; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8:216:3eff:fe9d:e7b4; helo=mslow3.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=bz5oivyu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8:216:3eff:fe9d:e7b4; helo=mslow3.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 835 seconds by postgrey-1.37 at boromir; Wed, 12 Feb 2025 19:38:22 AEDT
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [IPv6:2001:4b98:dc4:8:216:3eff:fe9d:e7b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtBXt4JMdz2ypD
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 19:38:22 +1100 (AEDT)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7393D58195B
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 08:24:31 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47D6E4328B;
	Wed, 12 Feb 2025 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739348660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oK2sPv4LMCXJy8yVS147MvhejzIS3HvMFZ7xWU0RsY=;
	b=bz5oivyuGG/36TQyTZOE5sUeuBIKSQJBW/yljLrkLTdZjG+Cs6bh2k6+82N7tC9enu90Z4
	VJbRY87FDapshatpYC1N07NfLXoTXJT6jPqyB04C7jHt2Q5Fv7eN+KUkIorip3hkP4hcYj
	6+UoxTH1wSVRlYNTp9itD0SMkZKzwDtyCwdo5ThOp2uhjLR3eKQp9XARWBmohWSz0d6KMr
	PsgJx7xzM6kZ15MoybZm46VArk45P9IkiQmck7C3nH4F7fe6o4EB0W68RZlCZszGdb3eHf
	NwNGkyI1pgcZuYe2m8JkeLYiWV1G4zIl8DWoTSsjhQOWGOx/NdP4yU7ntHe0Ug==
To: Tom Rini <trini@konsulko.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
In-Reply-To: <20250211212909.GI1233568@bill-the-cat> (Tom Rini's message of
	"Tue, 11 Feb 2025 15:29:09 -0600")
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
	<20250207155048.GX1233568@bill-the-cat>
	<CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
	<20250210164151.GN1233568@bill-the-cat>
	<7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
	<CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
	<20250211212909.GI1233568@bill-the-cat>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 12 Feb 2025 09:24:18 +0100
Message-ID: <8734gjsh8t.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhgsrghrohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhsihgrnhhgkhgroheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjnhhhuhgrnhhgleehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhmtghoshhtrgelgeegsehgmhgrihhlrdgtohhmpdhrtghpt
 hhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtoheplhhinhhugidqvghrohhfsheslhhishhtshdrohiilhgrsghsrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.0
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
From: Miquel Raynal via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Joao Marcos Costa <jmcosta944@gmail.com>, Jonathan Bar Or <jonathanbaror@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello Tom,

On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
>> Hi Tom and the rest of the team,
>>=20
>> Please let me know about fix time, whether this is acknowledged and
>> whether you're going to request CVE IDs for those or if I should do
>> it.
>> The reason is that I found similar issues in other bootloaders, so I'm
>> trying to synchronize all of them. For what it's worth, Barebox has
>> similar issues and are currently fixing.
>
> Yes, these seem valid. We don't have a CVE requesting authority so if
> you want them, go ahead and request them. You saw Gao Xiang's response
> for erofs, and I'm hoping one of the squashfs maintainers will chime
> in.

Either Jo=C3=A3o or me, we will have a look.

Thanks,
Miqu=C3=A8l
