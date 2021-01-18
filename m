Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7622FA533
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 16:53:24 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKGXd6kDLzDr0r
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Jan 2021 02:53:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DKGXH3ftzzDqXR
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Jan 2021 02:52:56 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [125.216.246.30])
 by front (Coremail) with SMTP id AWSowACnruKXrgVgbl7LAQ--.48661S3;
 Mon, 18 Jan 2021 23:52:05 +0800 (CST)
Date: Mon, 18 Jan 2021 23:52:05 +0800
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] erofs-utils: fix battach on full buffer block
Message-ID: <20210118155205.GA21706@DESKTOP-N4CECTO.huww98.cn>
References: <20210118123945.23676-1-sehuww@mail.scut.edu.cn>
 <20210118135916.GB2423918@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118135916.GB2423918@xiangao.remote.csb>
X-CM-TRANSID: AWSowACnruKXrgVgbl7LAQ--.48661S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47Xw15Kw13KrW7uF4DArb_yoW8Wr1Dpr
 WayF4Skr4Dt34rC3Zaqw1fZa4Sy3s5ArZ5Cw1qqF97ZFnxZr12grZYvr4jgFs0gF97tF4Y
 qa4Iv3s8A3yDX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAFwVW5WwCF04k20xvY
 0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
 0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAI
 cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
 CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4VbkUUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAFBlepTBDbiwAIs4
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

I would like to. If I understand it correctly, tests should based on
experimental-tests branch, and be submitted to this mail-list, too?

I wonder if we already have some CI service set up to run these tests
automatically? I saw a mail from Travis CI in the mail-list archive, but it
seems I don't have access to that organization.

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

