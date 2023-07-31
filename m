Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25542769473
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 13:16:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDwfq0hnWz2ytV
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 21:16:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDwfh4gvCz2yDR
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 21:16:27 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A42B067373; Mon, 31 Jul 2023 13:16:22 +0200 (CEST)
Date: Mon, 31 Jul 2023 13:16:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731111622.GA3511@lst.de>
References: <000000000000f43cab0601c3c902@google.com> <20230731093744.GA1788@lst.de> <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: brauner@kernel.org, jack@suse.cz, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>, sj1557.seo@samsung.com, linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 31, 2023 at 06:58:14PM +0800, Gao Xiang wrote:
> Previously, deactivate_locked_super() or .kill_sb() will only be
> called after fill_super is called, and .s_magic will be set at
> the very beginning of erofs_fc_fill_super().
>
> After ("fs: open block device after superblock creation"), such
> convension is changed now.  Yet at a quick glance,
>
> WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>
> in erofs_kill_sb() can be removed since deactivate_locked_super()
> will also be called if setup_bdev_super() is falled.  I'd suggest
> that removing this WARN_ON() in the related commit, or as
> a following commit of the related branch of the pull request if
> possible.

Agreed.  I wonder if we should really call into ->kill_sb before
calling into fill_super, but I need to carefull look into the
details.
