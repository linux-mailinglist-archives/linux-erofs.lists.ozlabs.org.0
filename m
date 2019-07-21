Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262B6F169
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jul 2019 06:07:11 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45rrmC6FKhzDqgB
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jul 2019 14:07:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ftp.linux.org.uk
 (client-ip=195.92.253.2; helo=zeniv.linux.org.uk;
 envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=zeniv.linux.org.uk
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45rrm7091lzDqdP
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jul 2019 14:06:57 +1000 (AEST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hp36f-000820-UA; Sun, 21 Jul 2019 04:06:06 +0000
Date: Sun, 21 Jul 2019 05:05:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v2 03/24] erofs: add super block operations
Message-ID: <20190721040547.GF17978@ZenIV.linux.org.uk>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
 <20190711145755.33908-4-gaoxiang25@huawei.com>
 <20190720224955.GD17978@ZenIV.linux.org.uk>
 <161cffc4-1d61-5dc6-45df-f1779ef03b0f@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161cffc4-1d61-5dc6-45df-f1779ef03b0f@aol.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Jul 21, 2019 at 11:08:42AM +0800, Gao Xiang wrote:

> It is for debugging use as you said below, mainly for our internal
> testers whose jobs are
> to read kmsg logs and catch kernel problems. sb->s_id (device number)
> maybe not
> straight-forward for them compared with dev_name...

Huh? ->s_id is something like "sdb7" - it's bdev_name(), not a device
number...

> The initial purpose of erofs_mount_private was to passing multi private
> data from erofs_mount
> to erofs_read_super, which was written before fs_contest was introduced.

That has nothing to do with fs_context (well, other than fs_context conversions
affecting the code very close to that).

> I agree with you, it seems better to just use s_id in community and
> delete erofs_mount_private stuffs...
> Yet I don't look into how to use new fs_context, could I keep using
> legacy mount interface and fix them all?

Sure.

> I guess if I don't misunderstand, that is another suggestion -- in
> short, leave all destructors to .kill_sb() and
> cleanup fill_super().

Just be careful with that iput() there - AFAICS, if fs went live (i.e.
if ->s_root is non-NULL), you really need it done only from put_super();
OTOH, for the case of NULL ->s_root ->put_super() won't be called at all,
so in that case you need it directly in ->kill_sb().
