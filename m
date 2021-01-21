Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1372FE3D0
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 08:22:48 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLv445GXbzDr0v
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 18:22:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DLv3v5nHGzDqYY
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 18:22:32 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [59.53.40.31])
 by front (Coremail) with SMTP id AWSowADHaACJKwlgejHZAQ--.10301S3;
 Thu, 21 Jan 2021 15:21:48 +0800 (CST)
Date: Thu, 21 Jan 2021 15:22:01 +0800
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] erofs-utils: fix battach on full buffer block
Message-ID: <20210121072201.GB6680@DESKTOP-N4CECTO.huww98.cn>
References: <20210119154335.GB2601261@xiangao.remote.csb>
 <32A61DA5-EED5-4268-B6C5-CAAB94527F91@mail.scut.edu.cn>
 <20210120051216.GA2688693@xiangao.remote.csb>
 <20210121060738.GA6680@DESKTOP-N4CECTO.huww98.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210121060738.GA6680@DESKTOP-N4CECTO.huww98.cn>
X-CM-TRANSID: AWSowADHaACJKwlgejHZAQ--.10301S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF13Gr1fZr1DXFWxXFy8AFb_yoWrJrykp3
 y7Ka1DKr4kJr1rAr1xtw1xXFyxtw1rGryYqr95WryI9rZ0vF1kCFyIyrWY9r97Wr48JFWj
 va18Xw1fJ3y5Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
 xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
 106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
 xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
 xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
 JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgg_TUUUUU
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAHBlepTBDfZQAGse
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

On Thu, Jan 21, 2021 at 02:07:38PM +0800, 胡玮文 wrote:
> Hi Xiang,
> 
> On Wed, Jan 20, 2021 at 01:12:16PM +0800, Gao Xiang wrote:
> > Hi Weiwen,
> > 
> > On Wed, Jan 20, 2021 at 12:57:39PM +0800, 胡玮文 wrote:
> > > 
> > > > 在 2021年1月19日，23:43，Gao Xiang <hsiangkao@redhat.com> 写道：
> > > > 
> > > > ﻿Hi Weiwen,
> > > > 
> > > >> On Tue, Jan 19, 2021 at 02:02:56PM +0800, 胡玮文 wrote:
> > > >> Hi Xiang,
> > > >> 
> > > >> After further investgate, this bug will not reveal in any released version of
> > > >> mkfs.erofs. Previous patch v5 [1] will map all allocated bb when erofs_mapbh()
> > > >> is called on an already mapped bb, which triggers this bug. before that patch,
> > > >> under the same condition, __erofs_battach() will only be called on bb which is
> > > >> not mapped, thus no need to update `tail_blkaddr'.
> > > > 
> > > > Good to know this, thanks! I haven't looked into that (I will test it this
> > > > weekend.) IMO, although this is not a regression, yet it seems it's potential
> > > > harmful if we didn't notice this... So I think a proper testcase is still
> > > > useful to look after this... If you have extra time, could you help on it?
> > > 
> > > Hi Xiang,
> > > 
> > > I’m working on this. I have written a test case for this. And I’m also working on setting up GitHub actions to run tests automatically. So far, I’ve got uncompressed tests works, but when lz4 is enable, all test (except 001) fail. I have not found out why. You may see my progress at https://github.com/huww98/erofs-utils/tree/experimental-tests. I will send patches once everything is sorted out.
> > 
> > It would be better to know which kernel version github action is used (at least
> > it seems no good if version is < 5.4)? also could you confirm the lz4 version
> > as well (lz4-1.9.3)? if erofsfuse is used, specify "FSTYP=erofsfuse make check"
> > to test it.
> 
> I've verified kernel version is 5.4.0-1032-azure for ubuntu-20.04, and erofs
> mount succeeded. for lz4, I'm installing v1.9.3 manually from source. I haven't
> tried fuse, will give it a try later. 
> 
> > The temporary results are in "tests/results/", could you also check and debug
> > it? (please kindly confirm the testcases work well on your local computer,
> > since such testcase is still WIP, I'm not sure if it has some running issues
> > as well)
> 
> I've downloaded "tests/results/" and it's test 007 (check for bad lz4 versions)
> that fails with output "test LZ4_compress_HC_destSize(1048576) error (4098 <
> 4116)". And it's the same error on my PC. Investigating.

OK, I realized I just need to run ldconfig after installing new version of liblz4.so
 
> BTW, why not use a more meaningful name for each test rather than a sequence
> number?
> 
> Hu Weiwen
>  
> > > 
> > > > Also, without the detail of this, I think the fix might be folded into
> > > > the original patchset (could you resend it?). In addition, I think after
> > > 
> > > You mean add a new commit [PATCH v6 3/3], or merge it into [PATCH v7 2/2]? I send it as a separate patch set because it may be merged independent of the cache.c optimization.
> > 
> > Resend v7 and fold it into [v7 2/2] would be better...
> > 
> > > 
> > > > last_mapped_block is introduced, we might not need tail_blkaddr anymore,
> > > > not sure. But I'm very cautious about this in case of introducing any
> > > > new regression...
> > > 
> > > I think we still need it, because already mapped bb may be dropped, last_map_block does not always reflect tail_blkaddr.
> > 
> > Okay, that makes sense...
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > Hu Weiwen
> > > 
> > > > Thanks,
> > > > Gao Xiang
> > > > 
> > > >> 
> > > >> [1]: https://lore.kernel.org/linux-erofs/20210118123431.22533-1-sehuww@mail.scut.edu.cn/
> > > >> 
> > > >> Hu Weiwen
> > > >> 

