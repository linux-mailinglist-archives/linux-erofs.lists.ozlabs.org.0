Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FF380E516
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 08:50:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sq9lP6LZXz30PH
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Dec 2023 18:50:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sq9lH6Phqz2ytJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Dec 2023 18:50:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyLlE91_1702367425;
Received: from 30.97.49.22(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VyLlE91_1702367425)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 15:50:27 +0800
Message-ID: <58d175f8-a06e-4b00-95fe-1bd5a79106df@linux.alibaba.com>
Date: Tue, 12 Dec 2023 15:50:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
To: Christoph Hellwig <hch@infradead.org>
References: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
 <941aff31-6aa4-4c37-bb94-547c46250304@linux.alibaba.com>
 <ZXgNQ85PdUKrQU1j@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZXgNQ85PdUKrQU1j@infradead.org>
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
Cc: nvdimm@lists.linux.dev, Colin Walters <walters@redhat.com>, Lokesh Mandvekar <lmandvek@redhat.com>, Stephen Smoogen <ssmoogen@redhat.com>, Yariv Rachmani <yrachman@redhat.com>, Brian Masney <bmasney@redhat.com>, Daniel Walsh <dwalsh@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, linux-unionfs@vger.kernel.org, Luca Boccassi <bluca@debian.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavol Brilla <pbrilla@redhat.com>, Eric Chanudet <echanude@redhat.com>, Alexander Larsson <alexl@redhat.com>, Lennart Poettering <lennart@poettering.net>, Neal Gompa <neal@gompa.dev>, linux-erofs@lists.ozlabs.org, Douglas Landgraf <dlandgra@redhat.com>, =?UTF-8?Q?Petr_=C5=A0abata?= <psabata@redhat.com>, Eric Curtin <ecurtin@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/12/12 15:35, Christoph Hellwig wrote:
> On Tue, Dec 12, 2023 at 08:50:56AM +0800, Gao Xiang wrote:
>> For non-virtualization cases, I guess you could try to use `memmap`
>> kernel option [2] to specify a memory region by bootloaders which
>> contains an EROFS rootfs and a customized init for booting as
>> erofs+overlayfs at least for `initoverlayfs`.  The main benefit is
>> that the memory region specified by the bootloader can be directly
>> used for mounting.  But I never tried if this option actually works.
>>
>> Furthermore, compared to traditional ramdisks, using direct address
>> can avoid page cache totally for uncompressed files like it can
>> just use unencoded data as mmaped memory.  For compressed files, it
>> still needs page cache to support mmaped access but we could adapt
>> more for persistent memory scenarios such as disable cache
>> decompression compared to previous block devices.
>>
>> I'm not sure if it's worth implementing this in kernelspace since
>> it's out of scope of an individual filesystem anyway.
> 
> IFF the use case turns out to be generally useful (it looks quite
> convoluted and odd to me), we could esily do an initdax concept where
> a chunk of memory passed by the bootloader is presented as a DAX device
> properly without memmap hacks.

I have no idea how it's faster than the current initramfs or initrd.
So if it's really useful, maybe some numbers can be posted first
with the current `memmap` hack and see it's worth going further with
some new infrastructure like initdax.

Thanks,
Gao Xiang


