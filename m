Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D46105FC12
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 18:46:53 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fkQf6S2bzDqd7
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Jul 2019 02:46:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1562258810;
	bh=EM1u+ZjVCCfW6STXfjJiLx71WAQ//phHm8jI4EyYnvs=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QokIP5ARxxmuLUGuZHm+XKCfxHOQXv05V0ByshfNWcj2ItkY91aHcnONYJtrgULeG
	 yZhZcGvKGNzH+Tjgy4MF+j4jCH9X2bMkw2qFIVdLiZXLM/t0tLgfgSVNOUkGn/+wNT
	 D8N/HMnSbqWfoXq4Pk+rMSlwragCgL8UvCmJTwzKCUJx+v6YE4rYWXKCICG/FJfxJM
	 MKTAunKrfwlR9jsunZtnkFVQUan56HPBuQTa3JWwrexwV6lKUnjjwtyfOrAuoSqoN9
	 a9uxQ2vzmbmr/ASdD8PSYJkH90jam+quWzhNxCeeiTTZJRlePUTqGvDmlAugD9bDIH
	 qctdaZmr9DsDA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.31; helo=sonic308-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="Jbehj5O5"; 
 dkim-atps=neutral
Received: from sonic308-55.consmr.mail.gq1.yahoo.com
 (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fkQV52yxzDqch
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Jul 2019 02:46:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1562258792; bh=EZlfHG9qy5wQ4KEgN887WZYPerk7S+APpyCQOSbTFhE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=Jbehj5O5hYjpjpSt0vPgVq1bE4rRkfL7AKxTplLtKnht8ThCsd/unenKgrfEdAjP/s4qNDS+0fhpgQtVCnuaOgFGopVaGRjm/zQ9d89poWon+QTZyDFCNAqzjVoUVnA0Q+6el1kTs/VvTw5WsWx3yS5Zo8iz3tlHR0oiik3U0iVD97p7nThjY1yMRjq3c8rnp8s6bnu8pbS3kZ19TgK6P2WXISg+D7LTVQu7eDuxB6J3ZX7ZuJKk27Cq5Rat6NxhM3ySYQODDGHzgcgWFh7eeiX1NlNETtRIIYvt0tzbS+fXrhEquw1ElW7nAUnkh71FzXaPEEAh0CIe6Qgh8sCHMw==
X-YMail-OSG: nPFdYIUVM1kSQ4ZioqeMyLSU.xw55DWLV66joC42IIiyjLduv75Diy8YoEierQM
 Yc.hHL6EcutscZzSr77xrgQQwkDvyzAQFYMAGboOrpn5rixShHSwguwA4rUNvtHm8z6IdbOwXIhj
 4KVxw5FD4qmD87NKoqTzly7EM5itiBbxp74urrXas_cvO03PKc4N2wI1NEgrR31x1L3Zc8yRUVEj
 .VfvxWAlEBLAvkvFc38uzotiTSZX_T4qYWDCpmlkZduIi_ceDX0Rz4xzmI74Hs79.6zN3GDUmMs2
 NLq.cMnRHw2nf.5D2DpFfw0Kq8Y3gvCc5WXP6GIm8WpiDQspAgUJwADw.JJ0ritziJovjRbcOrYD
 LLWr2dS974NJJfQoKQPoiGy7B669i1gTT1NaaZgTY.guGVIXa5hh93nJ6v8dYx56PpvWLoRV4J6z
 HAhPGnznrFgs5i2oKuZSoWyGAJ3eSHDXyguEBVgMqNrByjzjnrWTve46tUd6gmLCeuKvltiRaU04
 2Pn5I4s_B8cN_xnSU7gPKTapeTf.P5l3frPzHri4I4RcB3IXVNt07PPFJj870A3EHJROqC2Ejvbf
 kBvhb_AJHvByQ0qv0ITCvBRqMmvopMLtWxFEdFmqohohIkFMfS57DhU6D.MPkaICH9rdkffuaopD
 nn6ZO0U82MuHK.E7hd.n_C9YQBO5qUZG2xB0t.H5.2Zm_bFHtV3XOFQYe4_jQ9LYLLvYQpBU3KUX
 78hIdamLTGIcz.tB24ZrF0mMXXvHOMsQJuCpUrebMOmZHnHvJSdQHpPuDksDr1lo4AcNBZjbKbkN
 kZlZG9bXtX0npmjO3f8qqCa3e5XXzmtml4GfkE_oRnCZsMwq5d_7MzjAC2fQ4LsTr2M1I28EkMHg
 MRBp0Q.PvYeswI9V9SDd.GgE0ikY1KP.j.ySUv18VcKgp1eB_eNuZnYeszDckRd4i2E91hIeWW7z
 X5NPC_PVLbAqt6Ao4UtAoM1vEwlnJOHypeyGtDxW9CSGX_Td0c2bespvdR4PBcCg1nlgiLQy5Vse
 poml85TXXliq73dtWRl2AAizzXnsyFXG8Pz8OK1jOyg1_9nqcHBu.yY91T.d59eHRqndZ7NRQHOL
 GOopaFofG7EpdTrFURuXB1tTqDMNgy8wT.E0IpOo9O4EU5tiCv32JhzU86ovLzWgUPoTOMzhf42e
 sQbqOBRJHHrvvZWfvbUpb7v448eAJf7svif5ZksCHjQYR.8pQqWxjqcxQoOE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Thu, 4 Jul 2019 16:46:32 +0000
Received: by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 1631fc8e5a9a266c18b69f8870d578a3; 
 Thu, 04 Jul 2019 16:46:28 +0000 (UTC)
Subject: Re: [PATCH] erofs: promote erofs from staging
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gao Xiang <gaoxiang25@huawei.com>
References: <20190704133413.43012-1-gaoxiang25@huawei.com>
 <20190704135002.GB13609@kroah.com>
 <29e713d5-8146-80cf-8ffd-138b15349489@huawei.com>
 <20190704141819.GA5782@kroah.com>
Message-ID: <56db548b-a285-7862-dc84-2cd15d948431@aol.com>
Date: Fri, 5 Jul 2019 00:46:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704141819.GA5782@kroah.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, Theodore Ts'o <tytso@mit.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/4 ????10:18, Greg Kroah-Hartman wrote:
> On Thu, Jul 04, 2019 at 10:00:53PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2019/7/4 21:50, Greg Kroah-Hartman wrote:
>>> On Thu, Jul 04, 2019 at 09:34:13PM +0800, Gao Xiang wrote:
>>>> EROFS file system has been in Linux-staging for about a year.
>>>> It has been proved to be stable enough to move out of staging
>>>> by 10+ millions of HUAWEI Android mobile phones on the market
>>>> from EMUI 9.0.1, and it was promoted as one of the key features
>>>> of EMUI 9.1 [1], including P30(pro).
>>>>
>>>> EROFS is a read-only file system designed to save extra storage
>>>> space with guaranteed end-to-end performance by applying
>>>> fixed-size output compression, inplace I/O and decompression
>>>> inplace technologies [2] to Linux filesystem.
>>>>
>>>> In our observation, EROFS is one of the fastest Linux compression
>>>> filesystem using buffered I/O in the world. It will support
>>>> direct I/O in the future if needed. EROFS even has better read
>>>> performance in a large CR range compared with generic uncompressed
>>>> file systems with proper CPU-storage combination, which is
>>>> a reason why erofs can be landed to speed up mobile phone
>>>> performance, and which can be probably used for other use cases
>>>> such as LiveCD and Docker image as well.
>>>>
>>>> Currently erofs supports 4k LZ4 fixed-size output compression
>>>> since LZ4 is the fastest widely-used decompression solution in
>>>> the world and 4k leads to unnoticable read amplification for
>>>> the worst case. More compression algorithms and cluster sizes
>>>> could be added later, which depends on the real requirement.
>>>>
>>>> More informations about erofs itself are available at:
>>>>  Documentation/filesystems/erofs.txt
>>>>  https://kccncosschn19eng.sched.com/event/Nru2/erofs-an-introduction-and-our-smartphone-practice-xiang-gao-huawei
>>>>
>>>> erofs-utils (mainly mkfs.erofs now) is available at
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
>>>>
>>>> Preliminary iomap support has been pending in erofs mailing
>>>> list by Chao Yu. The key issue is that current iomap doesn't
>>>> support tail-end packing inline data yet, it should be
>>>> resolved later.
>>>>
>>>> Thanks to many contributors in the last year, the code is more
>>>> clean and improved. We hope erofs can be used in wider use cases
>>>> so let's promote erofs out of staging and enhance it more actively.
>>>>
>>>> Share comments about erofs! We think erofs is useful to
>>>> community as a part of Linux upstream :)
>>>
>>> I don't know if this format is easy for the linux-fsdevel people to
>>> review, it forces them to look at the in-kernel code, which makes it
>>> hard to quote.
>>>
>>> Perhaps just make a patch that adds the filesystem to the tree and after
>>> it makes it through review, I can delete the staging version?  We've
>>> been doing that for wifi drivers that move out of staging as it seems to
>>> be a bit easier.
>>
>> OK, I will resend the whole patchset later as you suggested, but it will
>> lack of information about some original authors and I'd like to know who
>> is responsible to merge this kind of request to Linux upstream... maybe Linus?
> 
> I don't know who adds new filesystems to the tree these days.  Usually
> you need to get some acks from the fsdevel developers first, and then it
> can go directly to Linus in one of the merge windows.

Hope that fs guys could eventually take some glances / time on erofs
since it's more useful than romfs/cramfs/squashfs for read-only
performance scenario since storage space is not tight and slow than 10
years before, even for some embedded devices such as mobile phones/pads.
and compression file system could not be designed for saving storage
space only like these...

I think except for unzip_vle.c (which works fine, but not very cleaned
as other files), erofs is clean enough for reviewing...

> 
>> And it could be more consistent to leave staging version for linux-5.3
>> because we still use it, but anyway, I will do it now.
> 
> Yeah, it's too late for 5.3-rc1, so don't worry.  I'll not delete
> anything until it's actually in someone else's tree on its way to Linus.

Sound great, I will tidy the whole patchset up and hope it eventually be
ok...

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
