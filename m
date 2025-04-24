Return-Path: <linux-erofs+bounces-225-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B8A9A060
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 07:14:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjkgF6BHsz3bn8;
	Thu, 24 Apr 2025 15:14:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745471689;
	cv=none; b=X7XigO3IFqNqIBdF19EBqwFQOecXxFFxQly7lgKmq2OT2lNeNFMsOKwiBvx5jzjrU2bqfSzDYLCIJM4RfiY/3KZKkC3qnN77clH6+NAn9n22ws4Mm7m+KTUAb5uE/ECvcTQr13a+dSb17FXxg8auww8f06Tx9umDj7lrbIrqkTQc7NwLqDMhVhT2PMbLj9V62TVGIWkaMMbcUCp51bG9wuCziUuasmnf7lXxFhakKBQsLvP+IP0sorQ9Ak2197+/HWMNS+BSJkTKdjaKW8rbu/TIZP/RnyimfoX3Uo2Ei4dXTcfDKr0dATQY4KXCwO5BP3UkmcO5rv+6aE6MT35bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745471689; c=relaxed/relaxed;
	bh=Y7b/FkAwTTMzKnfbfR2Lpq+H3cr3ZdMVYEgXp7+9oXk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NpSuQXmxhXZs1Jihi64dpBmJVZ8O/U/uWZnDVet/V8jEI38nS9z8uUVyBW8UfYfXqi0v3Zk3bnyw9R0IZnFpuYfWkF8kmpTOvpOnBCxVh/eibEho/LCpeGdcTfqLw9ThDvDsFBR1xEZp/Iqd2RmtuJscR2fV2IUa9JtdqHveGg2AD2s/khOipq7YShKHdmlqd8heSZLHeyYa8vuzEL5fLz0cmsgLz9L4pIAG2X9LAlNsVTobm5K1mM9HuC5vmV7ttMcuDqSR4p4NIJcxlD5gOHk8dguxvqKkcHtAz8tkDhRL7j4EuAD11X4zFNZVO4/hsKD6IGPky4u8iH+ooYJs8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xn--tkuka-m3a3v.nz; dkim=pass (2048-bit key; secure) header.d=xn--tkuka-m3a3v.nz header.i=@xn--tkuka-m3a3v.nz header.a=rsa-sha256 header.s=s1 header.b=YV5tv00r; dkim-atps=neutral; spf=none (client-ip=185.205.69.214; helo=mail.w14.tutanota.de; envelope-from=sh1efs@xn--tkuka-m3a3v.nz; receiver=lists.ozlabs.org) smtp.mailfrom=xn--tkuka-m3a3v.nz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xn--tkuka-m3a3v.nz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=xn--tkuka-m3a3v.nz header.i=@xn--tkuka-m3a3v.nz header.a=rsa-sha256 header.s=s1 header.b=YV5tv00r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=xn--tkuka-m3a3v.nz (client-ip=185.205.69.214; helo=mail.w14.tutanota.de; envelope-from=sh1efs@xn--tkuka-m3a3v.nz; receiver=lists.ozlabs.org)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjkgD4YqFz3blc
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 15:14:48 +1000 (AEST)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id A35D87E95F62
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 07:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745471654;
	s=s1; d=xn--tkuka-m3a3v.nz;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=Y7b/FkAwTTMzKnfbfR2Lpq+H3cr3ZdMVYEgXp7+9oXk=;
	b=YV5tv00r2TgtW93Rs4oW2QPLiiJY6T+ZkaGpTDxlEvBlECT5pxwQR9Au1zgTX1qJ
	z19O0yU2qqT20gVO6gjQXfvOAmrI0olj6oFisKlaWyst+fKYIcTnm/pM1yOMWHufjAf
	Rqxgf3fBDGlWfuxEugWnXo2dpCO25qeKQ3QZIvfiKbvedj7vX1XhQOFHsv5fM6OCrml
	kW+crUzanNhYhTaF3pheWToZkmN6ktr67meoMnI5zTGJpXTRdsss7ASepyB1219m2RN
	quGT9giVom+VP60cHX9XC22h6sjzPachxmdzs5N4kAkoaqd/1PHS1586Ya+Gyd1wBlc
	CiLS8hjOcQ==
Date: Thu, 24 Apr 2025 07:14:14 +0200 (CEST)
From: Simon Hosie <sh1efs@xn--tkuka-m3a3v.nz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Linux Erofs <linux-erofs@lists.ozlabs.org>
Message-ID: <OOaCwCu--F-9@xn--tkuka-m3a3v.nz>
In-Reply-To: <8beeddff-816d-40ad-ae8b-a7c40748a59c@linux.alibaba.com>
References: <OOZ5vdV--F-9@xn--tkuka-m3a3v.nz> <8beeddff-816d-40ad-ae8b-a7c40748a59c@linux.alibaba.com>
Subject: Re: [question] Status of dictionary preload compression?
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

23 Apr 2025, 17:27 by hsiangkao@linux.alibaba.com:

> Hi Simon,
>
> On 2025/4/24 03:24, Simon Hosie wrote:
>
>> I've struggled to determine if this is already a feature or in developme=
nt or not (possibly because of overloading of the term "dictionary"), so I =
apologise in advance if the following brief is redundant:
>>
>> Compressors like LZ4, zstd, and even gzip talk about "dictionary compres=
sion" meaning to pre-load the history window of the compressor and decompre=
ssor, before the file is processed, with pre-arranged patterns; so that bac=
k references can be made for text the first time it appears in the file, ra=
ther than having to build up that window from an empty set at the beginning=
 of the file by encoding everything as literals.
>>
>> This can lead to an improvement in compression ratio.
>>
>> It's generally only useful for small files because in a larger file the =
back-reference widow is established early and remains full of reference mat=
erial for the rest of the file; but this should also benefit block-based co=
mpression which faces a loss of history at every entry point.
>>
>> So that's what I'm talking about; and my question, simply, is is this is=
 a feature (or a planned feature) of erofs?=C2=A0 Something involving stori=
ng a set of uncompressed dictionary preload chunks within the filesystem wh=
ich are then used as the starting dictionary when compressing and decompres=
sing the small chunks of each file?
>>
>> In my imagination such a filesystem might provide a palette of uncompres=
sed, and page-aligned, dictionaries and each file (or each cluster?) would =
give an index to the entry which it will use.=C2=A0 Typically that choice m=
ight be implied by the file type, but sometimes files can have different di=
spositions as you seek through them, or a .txt file may contain English or =
Chinese or ASCII art, each demanding different dictionaries.=C2=A0 Making t=
he right choice is an external optimisation problem.
>>
>
> Thanks for your interest.
>
> I know the dictionary compression (and the benefit for small
> compression units as you said 4KiB compression) and it's on
> our TODO list for years.
>
> Actually I made an erofs-utils dictionary compresion demo 4
> years ago (but EROFS doesn't implement compression deduplication
> at that time):
> https://github.com/erofs/erofs-utils/tree/experimental-dictdemo
>
> The discussion part of this topic is the dictionary granularity:
>  1) per-filesystem ?  I think it's almost useless, but it
>  has least extra dictionary I/O.
>  2) per-inode?
>  3) per-(sub)inode?
>
> Since EROFS also supports compressed data deduplication (which
> means a pcluster can be used for different parts of an inode or
> different inodes), it makes the design for dictionary generation
> (since some uncompressed data can be deduplicated) and selection
> harder.
>
> If you have more ideas about the dictionary granularity and
> the whole process, I'm very interested in hearing more.
>
> Thanks,
> Gao Xiang
>
Ok, well the model I had in mind was to allocate maybe a few hundred kB of =
the filesystem image to various dictionaries optimised for different file t=
ypes.=C2=A0 Some plain text dictionaries, a generic JSON dictionary, a gene=
ric XML dictionary, a shared object dictionary, etc..., and you enumerate t=
hose so that each file can choose the right dictionary using just a one-byt=
e index into the table.

Hopefully an app will only work intensively with a couple of file types at =
a time so only a couple of dictionaries need be paged in at a time.
My intuition tells me that diminishing returns will have set in well before=
 256 different dictionaries, and that having more than that would be mostly=
 harmful; but I guess that's a thing which needs testing.
I understand right now every file can specify a compression method for itse=
lf, so in that same data structure it makes sense to also specify the index=
 number of the dictionary for the compression if the chosen compression met=
hod uses a dictionary.

By default mkfs would probably just look at the input files and a directory=
 full of pre-cooked dictionaries, and based on the extension of the file an=
d the availability of a matching dictionary it would put that dictionary in=
 the next slot and mark all matching files as being compressed against that=
 dictionary number.

Then the user can look at which sets of file types missed out on a dictiona=
ry and how much space they're using, and they can decide if they want to ma=
ke another dictionary for those files as well, or just make them share a di=
ctionary with another file type. Or maybe they want to split a group of fil=
es because they'll benefit from having different versions of a dictionary.=
=C2=A0 Or maybe they'll write their own optimiser to decide the optimal fil=
e groups by grinding on the problem with hundreds of GPUs for weeks on end.

If one file is particularly large it might warrant a dedicated dictionary, =
but I wouldn't plan for that as the general case.

Once those decisions have been finalised the dictionaries can be re-optimis=
ed against the actual files to get the best compression.

There's also the question of whether a file would want to select two or thr=
ee small dictionaries to concatenate.=C2=A0 Like, for an XML file containin=
g English tags and Chinese text, or something like that.=C2=A0 Or it might =
want to switch dictionaries halfway through the file.=C2=A0 That's probably=
 over-engineering, though.

I think that's more or less all the things I've thought about the problem s=
o far.

