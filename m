Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD746301560
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 14:19:45 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DNGtz63J1zDrgX
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Jan 2021 00:19:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DNGtY3YySzDrgK
 for <linux-erofs@lists.ozlabs.org>; Sun, 24 Jan 2021 00:19:14 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [59.53.41.187])
 by front (Coremail) with SMTP id AWSowABXXuIYIgxgjOvtAQ--.24648S3;
 Sat, 23 Jan 2021 21:18:19 +0800 (CST)
Date: Sat, 23 Jan 2021 21:18:30 +0800
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] erofs-utils: fuse: fix random readlink error
Message-ID: <20210123131830.GA16490@DESKTOP-N4CECTO.huww98.cn>
References: <20210122003416.GF2996701@xiangao.remote.csb>
 <86D0E0EF-4F13-4410-80C1-19B829A4D61D@mail.scut.edu.cn>
 <20210122014901.GB2918836@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210122014901.GB2918836@xiangao.remote.csb>
X-CM-TRANSID: AWSowABXXuIYIgxgjOvtAQ--.24648S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4rCF13KF4UArWkJFyUAwb_yoWrJFWrpr
 4UKF4jkF4ftry7Ar4I93W5Kas3t3s7Zr1UWrWkKay0vFnrtFnxWF18KayY9r97ur48Cr40
 vwsFqFZxuFy5ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
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
 Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8v_M3UUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAJBlepTBDjTwAQsQ
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

On Fri, Jan 22, 2021 at 09:49:01AM +0800, Gao Xiang wrote:
> Hi Weiwen,
> 
> On Fri, Jan 22, 2021 at 09:00:44AM +0800, 胡玮文 wrote:
> > Hi Xiang,
> > 
> > > 在 2021年1月22日，08:34，Gao Xiang <hsiangkao@redhat.com> 写道：
> > > 
> > > ﻿Hi Weiwen,
> > > 
> > >> On Fri, Jan 22, 2021 at 12:31:43AM +0800, Hu Weiwen wrote:
> > >> readlink should fill a **null terminated** string in buffer.
> > >> 
> > >> Also, read should return number of bytes remaining on EOF.
> > >> 
> > >> Link: https://lore.kernel.org/linux-erofs/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn/
> > >> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> > > 
> > > Thanks for catching this!
> > > 
> > >> ---
> > >> fuse/main.c | 14 +++++++++++++-
> > >> 1 file changed, 13 insertions(+), 1 deletion(-)
> > >> 
> > >> diff --git a/fuse/main.c b/fuse/main.c
> > >> index c162912..bc1e496 100644
> > >> --- a/fuse/main.c
> > >> +++ b/fuse/main.c
> > >> @@ -71,6 +71,12 @@ static int erofsfuse_read(const char *path, char *buffer,
> > >>    if (ret)
> > >>        return ret;
> > >> 
> > >> +    if (offset >= vi.i_size)
> > >> +        return 0;
> > >> +
> > >> +    if (offset + size > vi.i_size)
> > >> +        size = vi.i_size - offset;
> > >> +
> > > 
> > > It would be better to call erofs_pread() with the original offset
> > > and size (also I think there is some missing memset(0) for
> > > !EROFS_MAP_MAPPED), and fix up the return value to the needed value.
> > 
> > Yes, that is what I have initially tried. But this way is harder than I thought. 
> > EROFS_MAP_MAPPED flag seems to be designed to handle sparse file, and is reused to
> > represent EOF. So maybe we need a new flag to represent EOF? 
> 
> Nope, I think we just need to handle return value of read, I mean
> 
> erofs_ilookup()
> 
> ret = erofs_pread()
> if (ret)
> 	return ret;
> 
> if (offset + size > vi.i_size)
> 	return vi.i_size - offset;
> 
> return size;
> 
> Is that enough? Am I missing something?

This should work, except we should also add this branch

if (offset >= vi.i_size)
	return 0;

But how this is better than my original patch? I would say my patch should be
more efficient.

By saying "what I have initially tried" in my last mail, I mean changing
erofs_pread() to return the number of bytes read (just like pread system call,
instead of always 0). I think this is easier to understand for others, but
seems harder to implement. Do you think this is worthful?

> > So that we can distinguish EOF and hole in the middle, and return the bytes read.
> > Or we just abandon the sparse file support, and use EROFS_MAP_MAPPED to indicate
> > EOF exclusively. Since erofs current does not actually support this, right?
> 
> Actually, Pratik was working on it months ago, if you have some interest
> of uncompressed sparse files (since for compressed files, 0-ed data would
> be highly compressed by fixed-sized output compression.), could you pick
> his feature up if possible? That would be of great help to EROFS as long
> as you have some interest and extra time... :)
> 
> https://lore.kernel.org/r/20200102094732.31567-1-pratikshinde320@gmail.com/
> 
> Thanks,
> Gao Xiang
> 
> > 
> > > Thanks,
> > > Gao Xiang
> > > 
> > >>    ret = erofs_pread(&vi, buffer, size, offset);
> > >>    if (ret)
> > >>        return ret;
> > >> @@ -79,10 +85,16 @@ static int erofsfuse_read(const char *path, char *buffer,
> > >> 
> > >> static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
> > >> {
> > >> -    int ret = erofsfuse_read(path, buffer, size, 0, NULL);
> > >> +    int ret;
> > >> +    size_t path_len;
> > >> +
> > >> +    erofs_dbg("path:%s size=%zd", path, size);
> > >> +    ret = erofsfuse_read(path, buffer, size, 0, NULL);
> > >> 
> > >>    if (ret < 0)
> > >>        return ret;
> > >> +    path_len = min(size - 1, (size_t)ret);
> > >> +    buffer[path_len] = '\0';
> > >>    return 0;
> > >> }
> > >> 
> > >> -- 
> > >> 2.30.0
> > >> 
> > 

