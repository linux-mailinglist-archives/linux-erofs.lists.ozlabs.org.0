Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 62798680E2
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jul 2019 20:59:54 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45mwvW6hfgzDqVs
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2019 04:59:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ucw.cz
 (client-ip=195.113.26.193; helo=atrey.karlin.mff.cuni.cz;
 envelope-from=pavel@ucw.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ucw.cz
X-Greylist: delayed 535 seconds by postgrey-1.36 at bilbo;
 Mon, 15 Jul 2019 04:59:44 AEST
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45mwvN5WhGzDqVm
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jul 2019 04:59:44 +1000 (AEST)
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 08D2C804F1; Sun, 14 Jul 2019 20:50:26 +0200 (CEST)
Date: Sun, 14 Jul 2019 12:49:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v2 00/24] erofs: promote erofs from staging
Message-ID: <20190714104940.GA1282@xo-6d-61-c0.localdomain>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711145755.33908-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: devel@driverdev.osuosl.org, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu 2019-07-11 22:57:31, Gao Xiang wrote:
> Changelog from v1:
>  o resend the whole filesystem into a patchset suggested by Greg;
>  o code is more cleaner, especially for decompression frontend.
> 
> --8<----------
> 
> Hi,
> 
> EROFS file system has been in Linux-staging for about a year.
> It has been proved to be stable enough to move out of staging
> by 10+ millions of HUAWEI Android mobile phones on the market
> from EMUI 9.0.1, and it was promoted as one of the key features
> of EMUI 9.1 [1], including P30(pro).

Ok, maybe it is ready to be moved to kernel proper, but as git can
do moves, would it be better to do it as one commit?

Separate patches are still better for review, I guess.
							Pavel
