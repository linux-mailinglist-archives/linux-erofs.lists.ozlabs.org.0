Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D44987CF5
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 04:18:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XFDfB2NXKz309h
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 12:18:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727403504;
	cv=none; b=GGR9SpGm4TTVYhJpu0xR+BYSOrOjoiKO4RsONXzpsnhqF2nUUCgVH7JTxod5D0qj7K+EohpZuKFFnzbMBwLvfQZEyyTda0xgykC2SyPSpSvwHP4xcoPnKhMSyTd8exWWYAGCBxx3YNE2Oj8S//SlT3WoG8rCno1G5qt0F5W9Pub32W8tVhAkIb14ZO+DsLsWVt8Yks42jrI73/l/StlwVfJMhYMi7eghMF9nZMBfu+XeqEN4QEvMGD/gI0vwEh0vcjsN9nHU2xqTcdH7Mr5lV3ukDexaEPU44qrt0/Vd/ojEBBVcKL5J4F4FsZtJQ+rkoIRwdLTxkUyFK+JQJWiscA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727403504; c=relaxed/relaxed;
	bh=/r/tjBNR+IWRjvp0HptBoGnx5lgEQTTKVUb3akceKm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjtlLZ5q5XlSKmAk5VStBMDR30EEY3TIJPjzC8thafsLEFxeU+1tlVhbYl+9QIzhyr97qnkfznFVuWR+x1678hzZquJbnN4+YpoDVv8Ux4/PzckcepRXrgfVXHrWb4cx1+J4vvZopkf4lS8k63t/SUBeXAWQ9Vg6sJRvmrez9CvMh9h7ONstcF3YZjnqaK26KaKxaAa+BDLSlax0KzGCZS8nccCB/P7UipYbrjtaMFsZ1kqhb2m3lR+DxOcE41XSw5ZTHpmLozUbwGEaA4tnI6+r76j8cTyAPhMVuZP9DLjY0rgJAMCxX/5YmCxTHLwWPQGd/MaK36KC85EHWW5IfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YiyENYt1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YiyENYt1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XFDf427Pmz2yvs
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Sep 2024 12:18:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727403491; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/r/tjBNR+IWRjvp0HptBoGnx5lgEQTTKVUb3akceKm8=;
	b=YiyENYt1hF/ViFeQTlvlg7cca+v+jg3TEJbXEDyXWFuaDgep3QJUafYzelQM2HajEWUcL7IDEq+ICHr3VhtbIV7xny8kJNAh0DEOYNJIrsb12bx1b28Vsg8igIwwIYBznHY0lF5l5e2VlD4dbt328FodHx9UUOepFheiM0Vg0Cs=
Received: from 30.244.152.118(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFokCVX_1727403487)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 10:18:08 +0800
Message-ID: <7739346c-b98e-4359-b0d2-44cd73ae55f0@linux.alibaba.com>
Date: Fri, 27 Sep 2024 10:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
References: <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
 <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
 <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
 <ec17a30e-c63a-4615-8784-69aef2bb2bae@linux.alibaba.com>
 <20240926124959.n7i33p4fonp2op27@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926124959.n7i33p4fonp2op27@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Benno Lossin <benno.lossin@proton.me>, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/26 20:50, Ariel Miculas wrote:
> On 24/09/26 07:23, Gao Xiang wrote:

...

>>>
>>> It might be a fair comparison, but that's not how container images are
>>> distributed. You're trying to argue that I should just use EROFS and I'm
>>
>> First, OCI layer is just distributed like what I said.
>>
>> For example, I could introduce some common blobs to keep
>> chunks as chunk dictionary.   And then the each image
>> will be just some index, and all data will be
>> deduplicated.  That is also what Nydus works.
> 
> I don't really follow what Nydus does. Here [1] it says they're using
> fixed size chunks of 1 MB. Where is the CDC step exactly?

Dragonfly Nydus uses fixed-size chunks of 1MiB by default with
limited external blobs as chunk dictionaries.  And ComposeFS
uses per-file blobs.

Currently, Both are all EROFS users using different EROFS
features.  EROFS itself supports fixed-size chunks (unencoded),
variable-sized extents (encoded, CDC optional) and limited
external blobs.

Honestly, for your testload (10 versions of ubuntu:jammy), I
don't think CDC made a significant difference in the final
result compared to per-file blobs likewise.  Because most of
the files in these images are identical, I think there are
only binary differences due to CVE fixes or similar issues.
Maybe delta compression could do more help, but I never try
this.  So as I asked in [1], does ComposeFS already meet your
requirement?

Again, EROFS could keep every different extent (or each chunk,
whatever) as a seperate file with minor update, it's a trivial
stuff for some userspace archive system, but IMO it's
controversal for an in-tree kernel filesystem.

[1] https://github.com/project-machine/puzzlefs/issues/114#issuecomment-2369971291

Thanks,
Gao Xiang
