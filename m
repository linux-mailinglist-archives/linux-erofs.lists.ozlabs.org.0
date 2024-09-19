Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C04997CA58
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 15:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726753575;
	bh=NT33HsfNCSAYhZK5GJl2I4nckfuU7LN1MNbY5TeJz/U=;
	h=Date:To:Subject:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Da/u9QRBUB987ZQWz+MUma9ZywZ4Lw3StmCGHoMxoRIkizsgPCkFlJtpSWKSy+kqn
	 Rs8vusNQenQCPjeg3/n4BPSSX3vgTDbqnW16Xuca5Bqph2DAHVOrimL54dF03ZA/Nz
	 iYJoj88/eCqlZkCauTLtDv6HYRkROpvPmpQdhGV7L3IDWWD6sbmUKGpgd2gJSZ+YzB
	 Fj9uGEzYgvaQYPwA9adO++RY6hrKStKtu3QBfB1V4AcXIulOOvljyuYim+WQw86LVc
	 fr3FsSj5n+dSLj1SRPmusqfJkor0LbKgfAo6TUXbnPyuGztXjjPfISEpMRWNtfjzpH
	 JXLr652oGhQCg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X8cHW1nf7z2yN1
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 23:46:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.70.40.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726753568;
	cv=none; b=JmaJoPCNfnqfHLY8hiPxFQj+5HvdF6A4ijyRVFAIkO5+89CMqy5o+dmUhPjFhl4qk/Zt1XBW1JG1a8hsZNsZgLlhwhbnmcOMMwoYE/9solsXCtAVhynPLj7A0nSDwBtt5LyUkmvybfuEqVACs9Ho87MuZHV26TEANMMQ0hKJ65l+RknqQyP+pWuWrzFKQtu3ko5UAhVuiMpCExhbxdfAddSHDplMksN86YoQcSM/MJvFZnR9OrfLFcpFPrxjnrJPGoeN2S4W7fLTSP/1VzD9MO3hewmVS/mM0Io7CtubNgYL/HRmu4v1uAEMR4RIEXM6VDknL6vU/PDCfvzhxPAfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726753568; c=relaxed/relaxed;
	bh=NT33HsfNCSAYhZK5GJl2I4nckfuU7LN1MNbY5TeJz/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QA/VaTU/dpNLRnwTrZC9BMMzhB4vi9zi7VYeeQ1T9nif/C0GcLHRtyO7kqIJdOL7MdYfP0oIdRWl62KYVfSNu9IqNYf9ovaveBqlO0aNpkGK5vdfJi5ZXyj7EhM46ufDX5iD9Cuy1iwy1d91gnWtzHOhYERISwtmik9P9r/24P4YChPE8yfeYa2p6QONJQXbnbpg5tj7qWyEHl+yu4MRdTo+yWt9LnVDF+yH8z48JdC7YoBkXS3bPKUdhVX7Vt/JkSb3VWeLWXdHhPMo61jN3HjYxO64mi+P6Rq6K0YWuakc5l5pw++4+o6rjaq4gjAfQpHlyLRVxdbphpQiBhD/pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail header.b=W/c+d0T9; dkim-atps=neutral; spf=pass (client-ip=185.70.40.133; helo=mail-40133.protonmail.ch; envelope-from=benno.lossin@proton.me; receiver=lists.ozlabs.org) smtp.mailfrom=proton.me
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail header.b=W/c+d0T9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=proton.me (client-ip=185.70.40.133; helo=mail-40133.protonmail.ch; envelope-from=benno.lossin@proton.me; receiver=lists.ozlabs.org)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X8cHL10TVz2yFJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Sep 2024 23:46:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726753559; x=1727012759;
	bh=NT33HsfNCSAYhZK5GJl2I4nckfuU7LN1MNbY5TeJz/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W/c+d0T9UMJnzXhcPX0tffEyYNAXdVQ+ZIaXB0VTMs1MRV7bUq5IwH9btO4HfM1pJ
	 yGSUotJheJm/LCtYz6S53Q6FMYIfvb8Tv7FEwJor03A+vLxB/NOJwouepTn+dPx83z
	 cM5+ywIXqOdJrklOAEOTBTmVcm0li0VJYCOZNGV0YOgDFSk2fBea4iSpnBx+E1NBx4
	 i9YtFWce7sywTDWT7nYWo2fvilMHPrcOdMs4fdQNw7k+3+Ua0Pjr4BIw8jKepNT8ph
	 hM6CNgXzRMkHrf2kE1k8nXbQpOml2SzPCIkoZ+3yyqakRpDn+mhr45jPiecfE5R9eY
	 Mhntehp3wQNUg==
Date: Thu, 19 Sep 2024 13:45:56 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gary Guo <gary@garyguo.net>, Yiyang Wu <toolmanp@tlmp.cc>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
In-Reply-To: <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
References: <20240916135634.98554-1-toolmanp@tlmp.cc> <20240916135634.98554-4-toolmanp@tlmp.cc> <20240916210111.502e7d6d.gary@garyguo.net> <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b8d97f78ee362a1aa80e09e4076bc52d0a830dd6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
From: Benno Lossin via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Benno Lossin <benno.lossin@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

Thanks for the patch series. I think it's great that you want to use
Rust for this filesystem.

On 17.09.24 01:58, Gao Xiang wrote:
> On 2024/9/17 04:01, Gary Guo wrote:
>> Also, it seems that you're building abstractions into EROFS directly
>> without building a generic abstraction. We have been avoiding that. If
>> there's an abstraction that you need and missing, please add that
>> abstraction. In fact, there're a bunch of people trying to add FS
>=20
> No, I'd like to try to replace some EROFS C logic first to Rust (by
> using EROFS C API interfaces) and try if Rust is really useful for
> a real in-tree filesystem.  If Rust can improve EROFS security or
> performance (although I'm sceptical on performance), As an EROFS
> maintainer, I'm totally fine to accept EROFS Rust logic landed to
> help the whole filesystem better.

As Gary already said, we have been using a different approach and it has
served us well. Your approach of calling directly into C from the driver
can be used to create a proof of concept, but in our opinion it is not
something that should be put into mainline. That is because calling C
from Rust is rather complicated due to the many nuanced features that
Rust provides (for example the safety requirements of references).
Therefore moving the dangerous parts into a central location is crucial
for making use of all of Rust's advantages inside of your code.

> For Rust VFS abstraction, that is a different and indepenent story,
> Yiyang don't have any bandwidth on this due to his limited time.

This seems a bit weird, you have the bandwidth to write your own
abstractions, but not use the stuff that has already been developed?

I have quickly glanced over the patchset and the abstractions seem
rather immature, not general enough for other filesystems to also take
advantage of them. They also miss safety documentation and are in
general poorly documented.

Additionally, all of the code that I saw is put into the `fs/erofs` and
`rust/erofs_sys` directories. That way people can't directly benefit
from your code, put your general abstractions into the kernel crate.
Soon we will be split the kernel crate, I could imagine that we end up
with an `fs` crate, when that happens, we would put those abstractions
there.

As I don't have the bandwidth to review two different sets of filesystem
abstractions, I can only provide you with feedback if you use the
existing abstractions.

> And I _also_ don't think an incomplete ROFS VFS Rust abstraction
> is useful to Linux community

IIRC Wedson created ROFS VFS abstractions before going for the full
filesystem. So it would definitely be useful for other read-only
filesystems (as well as filesystems that also allow writing, since last
time I checked, they often also support reading).

> (because IMO for generic interface
> design, we need a global vision for all filesystems instead of
> just ROFSes.  No existing user is not an excuse for an incomplete
> abstraction.)

Yes we need a global vision, but if you would use the existing
abstractions, then you would participate in this global vision.

Sorry for repeating this point so many times, but it is *really*
important that we don't have multiple abstractions for the same thing.

> If a reasonble Rust VFS abstraction landed, I think we will switch
> to use that, but as I said, they are completely two stories.

For them to land, there has to be some kind of user. For example, a rust
reference driver, or a new filesystem. For example this one.

---
Cheers,
Benno

