Return-Path: <linux-erofs+bounces-234-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 280A5A9BD7F
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Apr 2025 06:20:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZkKPw20rFz2yRD;
	Fri, 25 Apr 2025 14:20:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745554820;
	cv=none; b=W/UN8qYDj098DjfiOxcoRJRma64NphrdY7wMP5oid9bOf/gK/hbqNaFvcbulsN6xxe6LdDfD3B8BvPpl2WqZIbwhDjFtYkNKpVjvXm591hXfWpEVFKTX10lxV5wju6LdWAHC0Lt9yQ49UN3puhcLrcJDcHA82CwjAvme5S20T+0PNyBFYoPzhJdOYgQkG1ptLqQOJ1glZxpIfnO6ebmbldjB5PjmMpvRdsrXpAFPY3K9J+RtuB5IFuLXdiPO/NZC2+Vp9YUPxc2hmsWzMhLBiFg6xxmZkboHQEub3rPE2RNJoKr2AwVA+C1GjtCiKiY0+XVnwV4IpLJOg9olEPygKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745554820; c=relaxed/relaxed;
	bh=pItWmD7C2Zc+G3bzjyhFIipPlLieI9DoUxD3cqCRZpg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oDYfzEznN9noKib5UGXeQoLf8CgxDsgy5kzOMhK+RMe92cqOjJIaNQF7P98Jv8bASB89v+2Ibh5AXQyHZumhnsXKWE/58D0eqh5T3AFXDPx9/A+bUfGUZtmIKUbjdQzoT9KpGg3TTvEDiOMtxpO5D8SE0N+cW/JLIf5LpNfKXAXuu/FTrmO/cKfv5rjmk2cJZuU9d26Cvw6XKy8XZDduX0kpb/5yuOvjVKCuH3qQdztyFVFfNhbcNFiffYLHwxZ8bg3yapUQgzEdV4sKuQXqA27m/OfqAWMoBiOV43KrDwEmJFvCKkSbExqp44isrY0HLQhh/itCbuf8UQZ/eSq6yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xn--tkuka-m3a3v.nz; dkim=pass (2048-bit key; secure) header.d=xn--tkuka-m3a3v.nz header.i=@xn--tkuka-m3a3v.nz header.a=rsa-sha256 header.s=s1 header.b=JFnXrhgc; dkim-atps=neutral; spf=none (client-ip=185.205.69.214; helo=mail.w14.tutanota.de; envelope-from=sh1efs@xn--tkuka-m3a3v.nz; receiver=lists.ozlabs.org) smtp.mailfrom=xn--tkuka-m3a3v.nz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xn--tkuka-m3a3v.nz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=xn--tkuka-m3a3v.nz header.i=@xn--tkuka-m3a3v.nz header.a=rsa-sha256 header.s=s1 header.b=JFnXrhgc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=xn--tkuka-m3a3v.nz (client-ip=185.205.69.214; helo=mail.w14.tutanota.de; envelope-from=sh1efs@xn--tkuka-m3a3v.nz; receiver=lists.ozlabs.org)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZkKPt2jS0z2y8t
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Apr 2025 14:20:17 +1000 (AEST)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id B37DC7F16772
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Apr 2025 06:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745554813;
	s=s1; d=xn--tkuka-m3a3v.nz;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=pItWmD7C2Zc+G3bzjyhFIipPlLieI9DoUxD3cqCRZpg=;
	b=JFnXrhgc3wywP2w1Sh2+Hs3/Mk1DfUwvSf9LtNNE7hwdPbjpW12peBi/JeNuhaQa
	hYU/CnzsK7eSancOU0Pv4yWKcg9n9BMqnu0eYLFShTO4Y1Oiikmn33wLmAHIri4C880
	X5Ok2PT13ikIxClrY9MhOj+MZtgHyfOazvcuhZbvQkYkU63c9gCItsAOR1v84HPNNex
	k3ojqEd6cNkYI4+q7tPxrInqed6k7tpHxqKclKcEcD6hvUE71fJCZqPK7TInVLaAsPm
	yrcWhLt7wftGowBtSKcFIcm9DXi9gykby0iEpiq/McikE9dvb6D/z5I3w5S9YK6uzSO
	cj3yLFY60A==
Date: Fri, 25 Apr 2025 06:20:13 +0200 (CEST)
From: Simon Hosie <sh1efs@xn--tkuka-m3a3v.nz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Linux Erofs <linux-erofs@lists.ozlabs.org>
Message-ID: <OOfA9vE--F-9@xn--tkuka-m3a3v.nz>
In-Reply-To: <001afbdc-27a7-4adf-abd7-21d1053ee399@linux.alibaba.com>
References: <OOZ5vdV--F-9@xn--tkuka-m3a3v.nz> <8beeddff-816d-40ad-ae8b-a7c40748a59c@linux.alibaba.com> <OOaCwCu--F-9@xn--tkuka-m3a3v.nz> <001afbdc-27a7-4adf-abd7-21d1053ee399@linux.alibaba.com>
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


24 Apr 2025, 05:02 by hsiangkao@linux.alibaba.com:

> On 2025/4/24 13:14, Simon Hosie wrote:
>
>> 23 Apr 2025, 17:27 by hsiangkao@linux.alibaba.com:
>>
>>> Hi Simon,
>>>
>>> On 2025/4/24 03:24, Simon Hosie wrote:
>>>
>>>> I've struggled to determine if this is already a feature or in develop=
ment or not (possibly because of overloading of the term "dictionary"), so =
I apologise in advance if the following brief is redundant:
>>>>
>>>> Compressors like LZ4, zstd, and even gzip talk about "dictionary compr=
ession" meaning to pre-load the history window of the compressor and decomp=
ressor, before the file is processed, with pre-arranged patterns; so that b=
ack references can be made for text the first time it appears in the file, =
rather than having to build up that window from an empty set at the beginni=
ng of the file by encoding everything as literals.
>>>>
>>>> This can lead to an improvement in compression ratio.
>>>>
>>>> It's generally only useful for small files because in a larger file th=
e back-reference widow is established early and remains full of reference m=
aterial for the rest of the file; but this should also benefit block-based =
compression which faces a loss of history at every entry point.
>>>>
>>>> So that's what I'm talking about; and my question, simply, is is this =
is a feature (or a planned feature) of erofs?=C2=A0 Something involving sto=
ring a set of uncompressed dictionary preload chunks within the filesystem =
which are then used as the starting dictionary when compressing and decompr=
essing the small chunks of each file?
>>>>
>>>> In my imagination such a filesystem might provide a palette of uncompr=
essed, and page-aligned, dictionaries and each file (or each cluster?) woul=
d give an index to the entry which it will use.=C2=A0 Typically that choice=
 might be implied by the file type, but sometimes files can have different =
dispositions as you seek through them, or a .txt file may contain English o=
r Chinese or ASCII art, each demanding different dictionaries.=C2=A0 Making=
 the right choice is an external optimisation problem.
>>>>
>>>
>>> Thanks for your interest.
>>>
>>> I know the dictionary compression (and the benefit for small
>>> compression units as you said 4KiB compression) and it's on
>>> our TODO list for years.
>>>
>>> Actually I made an erofs-utils dictionary compresion demo 4
>>> years ago (but EROFS doesn't implement compression deduplication
>>> at that time):
>>> https://github.com/erofs/erofs-utils/tree/experimental-dictdemo
>>>
>>> The discussion part of this topic is the dictionary granularity:
>>>  1) per-filesystem ?  I think it's almost useless, but it
>>>  has least extra dictionary I/O.
>>>  2) per-inode?
>>>  3) per-(sub)inode?
>>>
>>> Since EROFS also supports compressed data deduplication (which
>>> means a pcluster can be used for different parts of an inode or
>>> different inodes), it makes the design for dictionary generation
>>> (since some uncompressed data can be deduplicated) and selection
>>> harder.
>>>
>>> If you have more ideas about the dictionary granularity and
>>> the whole process, I'm very interested in hearing more.
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>> Ok, well the model I had in mind was to allocate maybe a few hundred kB =
of the filesystem image to various dictionaries optimised for different fil=
e types.=C2=A0 Some plain text dictionaries, a generic JSON dictionary, a g=
eneric XML dictionary, a shared object dictionary, etc..., and you enumerat=
e those so that each file can choose the right dictionary using just a one-=
byte index into the table.
>>
>> Hopefully an app will only work intensively with a couple of file types =
at a time so only a couple of dictionaries need be paged in at a time.
>> My intuition tells me that diminishing returns will have set in well bef=
ore 256 different dictionaries, and that having more than that would be mos=
tly harmful; but I guess that's a thing which needs testing.
>> I understand right now every file can specify a compression method for i=
tself, so in that same data structure it makes sense to also specify the in=
dex number of the dictionary for the compression if the chosen compression =
method uses a dictionary.
>>
>> By default mkfs would probably just look at the input files and a direct=
ory full of pre-cooked dictionaries, and based on the extension of the file=
 and the availability of a matching dictionary it would put that dictionary=
 in the next slot and mark all matching files as being compressed against t=
hat dictionary number.
>>
>> Then the user can look at which sets of file types missed out on a dicti=
onary and how much space they're using, and they can decide if they want to=
 make another dictionary for those files as well, or just make them share a=
 dictionary with another file type. Or maybe they want to split a group of =
files because they'll benefit from having different versions of a dictionar=
y.=C2=A0 Or maybe they'll write their own optimiser to decide the optimal f=
ile groups by grinding on the problem with hundreds of GPUs for weeks on en=
d.
>>
>> If one file is particularly large it might warrant a dedicated dictionar=
y, but I wouldn't plan for that as the general case.
>>
>> Once those decisions have been finalised the dictionaries can be re-opti=
mised against the actual files to get the best compression.
>>
>> There's also the question of whether a file would want to select two or =
three small dictionaries to concatenate.=C2=A0 Like, for an XML file contai=
ning English tags and Chinese text, or something like that.=C2=A0 Or it mig=
ht want to switch dictionaries halfway through the file.=C2=A0 That's proba=
bly over-engineering, though.
>>
>> I think that's more or less all the things I've thought about the proble=
m so far.
>>
>
> Ok, I know your idea on this. My overall thought is to get the
> numbers and demo first, and then think more how to land this.
> If you're interested in developping this, that's awesome!
>
> BTW, one part I'm not sure if you noticed is that small files
> (or even the whole files) can be moved to the virtual fragment
> inode and compression together by using `-Efragments` (or even
> `-Eall-fragments`) option.
>
> So I think we have to develop sub-file dictionary support,
> otherwise it will be conflict with fragment compression feature.
>
> Thanks,
> Gao Xiang
>
I'm not sure if I can find the time to do the research myself, but I think =
it's at least important to note all my assumptions and open questions anywa=
y.=C2=A0 That might make it easier to formalise into a set of research task=
s for an interested volunteer.

But I might find time to experiment with it.=C2=A0 But I should focus on my=
 day job.=C2=A0 But just in case, is there a test corpus for benchmarking f=
ilesystem compression that I should run tests on?
* How big do the dictionaries need to be?=C2=A0 Do they have to all be the =
same size?=C2=A0 I think they certainly have to be multiples of the MMU pag=
e size so they can be page-aligned on disk.

* If a small dictionary suffices, is it ok to pack two unrelated dictionari=
es together in the same slot so that two different file types can use diffe=
rent parts of the same dictionary?

* Is it true that the needs of all realistic filesystems can be met with fe=
wer than 256 dictionaries for the whole system?=C2=A0 How many is a reasona=
ble goal or a reasonable upper limit?

* Are there cases where multiple dictionaries per file have enough impact t=
o justify the complexity?

Of course, it might actually be easier to implement if the dictionary numbe=
r is specified separately on every cluster?=C2=A0 In which case, it's defin=
itely better to allow that flexibility.=C2=A0 =C2=A0Even if the default beh=
aviour is to just use the same dictionary for the whole file, it's a tiny o=
verhead which could be used better in future revisions of mkfs.

I think for the tail merging cases, the natural thing to do is to only merg=
e tails of files of the same type.=C2=A0 Or only files using the same compr=
ession dictionary.=C2=A0 Even without a dictionary involved it should alway=
s be preferable to merge tails of files of the same type because they're mu=
ch more likely to share strings which can compress together.=C2=A0 It's not=
 optimal to merge the tail of an HTML file with the tail of a PNG file and =
try to share the same compression, for example.=C2=A0 Merge all the HTML ta=
ils together first.

