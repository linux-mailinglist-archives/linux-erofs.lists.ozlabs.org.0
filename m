Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AE3541F7
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 14:11:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDTzV3WXqz304T
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 22:11:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FDTzR0ywdz2yyj
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Apr 2021 22:11:45 +1000 (AEST)
Received: from laptop (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowABHT9dj_mpgcCUaAA--.12552S3;
 Mon, 05 Apr 2021 20:11:20 +0800 (CST)
Date: Mon, 5 Apr 2021 20:11:35 +0800
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] erofs-utils: get rid of inode->i_srcpath
Message-ID: <20210405121135.GA159690@laptop>
References: <20210405094950.150983-1-sehuww@mail.scut.edu.cn>
 <20210405113525.GB378859@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405113525.GB378859@xiangao.remote.csb>
X-CM-TRANSID: AWSowABHT9dj_mpgcCUaAA--.12552S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur17uFWkXry5Jr4xKryUZFb_yoW8GFyfpr
 4xCFyfK3W5t3srWr1Iyw1UXr93K393Jr98Ga4Fvr4kuFsxWFyvvryftasF9ryDury0yay0
 va1jvry5W3yDAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I
 3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
 WUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
 wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
 k0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
 Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8pnQUUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQASBlepTBMIEQAfsy
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Apr 05, 2021 at 07:35:25PM +0800, Gao Xiang wrote:
> Hi Weiwen,
> 
> On Mon, Apr 05, 2021 at 05:49:50PM +0800, Hu Weiwen wrote:
> > This cut the memory usage by half.
> > 
> > Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> > ---
> 
> I have to hold on this patch for now, 3 main reasons here:
>  1) I'd like to apply big pcluster first, which is a main new feature
>     for erofs-utils 1.3;

OK

>  2) even though it saves memory usage (and not sure how much memory
>     you need to save), I think srcpath is more useful for debugging
>     and file tracing; Also, I think we could flush inode in advance to
>     save memory usage (e.g. by using bflush()) as well.

I think flush in advance is a good idea. But it needs more investigation.
Ideally, I want to make the space complexity O(1), so that we can pack an
arbitrarily large number of files. It's better not to save every seen inode
structure in memory.

If I remember it correctly, when packing a dataset consisting of ~5m files,
mkfs.erofs takes 30-40GiB memory. I think this can hinder some use cases.

As for debugging, maybe we can create a routine that travels up the directory
tree to rebuild the path when needed? (Just like `pwd'.) Or, for mkfs, we can
just pass around a pointer to the current working path.

Thanks,
Hu Weiwen

>  3) if src_path is too large, how about malloc() it as the first step,
>     even that, I'd like to apply it after erofs-utils 1.3 is out...
> 
> Thanks,
> Gao Xiang

