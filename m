Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D0041AA30
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 09:54:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJWxm4kM2z2yPG
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 17:54:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJWxc6gkxz2xtf
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 17:54:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R341e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Upun2KJ_1632815662; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Upun2KJ_1632815662) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Sep 2021 15:54:24 +0800
Date: Tue, 28 Sep 2021 15:54:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Qi Wang <mpiglet@outlook.com>
Subject: Re: [PATCH v3 1/5] erofs-utils: introduce dump.erofs
Message-ID: <YVLKLkAzF+EXQH4S@B-P7TQMD6M-0146.local>
References: <20210915093537.2579575-1-guoxuenan@huawei.com>
 <YU/nRm9ug/kFXHBD@B-P7TQMD6M-0146.local>
 <YVJ/DVHlUG83A3Jk@B-P7TQMD6M-0146.local>
 <OSZP286MB07097AE45E9D391B0049F661B2A89@OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSZP286MB07097AE45E9D391B0049F661B2A89@OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM>
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

Hi Qi,

On Tue, Sep 28, 2021 at 02:23:30PM +0800, Qi Wang wrote:
> Hi,
> 
> On 2021/9/28 10:33 上午, Gao Xiang wrote:
> > Hi,
> > 
> > On Sun, Sep 26, 2021 at 11:21:42AM +0800, Gao Xiang wrote:
> > > Hi Xuenan and Qi,
> > > 
> > > On Wed, Sep 15, 2021 at 05:35:33PM +0800, Guo Xuenan wrote:
> > > > From: Wang Qi<mpiglet@outlook.com>
> > > > 
> > > > Add dump-tool for erofs to facilitate users directly
> > > > analyzing the erofs image file.
> > > > 
> > > > Signed-off-by: Guo Xuenan<guoxuenan@huawei.com>
> > > > Signed-off-by: Wang Qi<mpiglet@outlook.com>
> > > I'm almost fine with the series, and I will merge some of the patches
> > > later.
> > > 
> > > Due to busy work, my original plan was to fix some nits by myself and
> > > apply. Anyway, I will reply some comments this evening...
> > I've merged the first 2 patches into dev branch with modification (so no
> > need to resend the first two patches).
> > 
> > The rest patches are still a bit messy, I've set up a new
> > experimental-dump branch, please check out:
> > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/?h=experimental-dump
> > 
> > There are some stuffs needing to be resolved in advance:
> >   1) rename all "dumpfs_" prefix into "erofsdump_";
> >   2) I feel still uncomfortable when reading get_path_by_nid() and
> >      erofs_read_dir(). Could we refactor them by introducing
> >      erofs_for_each_dir() or likewise?
> >   3) file_category_types and the switch in dumpfs_print_inode() are
> >      duplicated to me. I think one of them can be removed instead.
> >   4) please help using "filefrag -v -b1" style when printing extent info
> >      in erofsdump_show_inode_phy(), like below:
> > 
> >   ext:     logical_offset:        physical_offset: length:   expected: flags:
> >     0:        0..   20479: 21788270592..21788291071:  20480:             last,eof
> > 
> > Thanks,
> > Gao Xiang
> > 
> Thanks for your reply! I will refactor the code according to your advice.

Nice! Many thanks for your time and contribution! :)

Thanks,
Gao Xiang

> 
> Thanks,
> Wang Qi
