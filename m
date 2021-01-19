Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B292FB11F
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 07:03:35 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKdPc22vhzDr0k
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 17:03:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DKdPT3Dq1zDqyZ
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Jan 2021 17:03:21 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowAA3PuIFdgZg7vPOAQ--.53029S3;
 Tue, 19 Jan 2021 14:02:48 +0800 (CST)
Date: Tue, 19 Jan 2021 14:02:56 +0800
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] erofs-utils: fix battach on full buffer block
Message-ID: <20210119060256.GA7664@DESKTOP-N4CECTO.huww98.cn>
References: <20210118123945.23676-1-sehuww@mail.scut.edu.cn>
 <20210118135916.GB2423918@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118135916.GB2423918@xiangao.remote.csb>
X-CM-TRANSID: AWSowAA3PuIFdgZg7vPOAQ--.53029S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw15KF45Gw48KFy8GrW7Jwb_yoW8ArWfpr
 W2ka1kKr4Dt34FyFnaqw1rZrySy3s5JrZ3Cw10qas3ZrnxZF1DWrWvvrW5WFZ8XF92yF40
 q3W2vas8ArWDZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY02Avz4vE14v_GF1l42xK82IY
 c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
 026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF
 0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
 vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jzuWdUUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAFBlepTBDbiwANs9
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

Hi Xiang,

After further investgate, this bug will not reveal in any released version of
mkfs.erofs. Previous patch v5 [1] will map all allocated bb when erofs_mapbh()
is called on an already mapped bb, which triggers this bug. before that patch,
under the same condition, __erofs_battach() will only be called on bb which is
not mapped, thus no need to update `tail_blkaddr'.

[1]: https://lore.kernel.org/linux-erofs/20210118123431.22533-1-sehuww@mail.scut.edu.cn/

Hu Weiwen

On Mon, Jan 18, 2021 at 09:59:16PM +0800, Gao Xiang wrote:
> Hi Weiwen,
> 
> On Mon, Jan 18, 2021 at 08:39:45PM +0800, Hu Weiwen wrote:
> > When __erofs_battach() is called on an buffer block of which
> > (bb->buffers.off % EROFS_BLKSIZ == 0), `tail_blkaddr' will not be
> > updated correctly. This bug can be reproduced by:
> > 
> > mkdir bug-repo
> > head -c 4032 /dev/urandom > bug-repo/1
> > head -c 4095 /dev/urandom > bug-repo/2
> > head -c 12345 /dev/urandom > bug-repo/3  # arbitrary size
> > mkfs.erofs -Eforce-inode-compact bug-repo.erofs.img bug-repo
> > 
> > Then mount this image and see that file `3' in the image is different
> > from `bug-repo/3'.
> > 
> > This patch fix this by:
> > 
> > * Don't inline tail-end data in this case, since the tail-end data will
> > be in a different block from inode.
> > * Correctly handle `battach' in this case.
> > 
> 
> I will evaluate this condition later, yet if you have some interest
> and extra time, could you also help on writing a regression testcase
> for this, so we can look after such regression in case of the future
> code changes?
> 
> This is also an ongoing work for the next erofs-utils release, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/
> 
> Thanks,
> Gao Xiang

