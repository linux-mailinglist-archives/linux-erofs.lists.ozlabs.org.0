Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC30769204
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 11:44:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDtc65StZz2ytT
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jul 2023 19:44:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 369 seconds by postgrey-1.37 at boromir; Mon, 31 Jul 2023 19:43:59 AEST
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDtbz6Gn8z2yDd
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jul 2023 19:43:59 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C14EF67373; Mon, 31 Jul 2023 11:37:44 +0200 (CEST)
Date: Mon, 31 Jul 2023 11:37:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731093744.GA1788@lst.de>
References: <000000000000f43cab0601c3c902@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f43cab0601c3c902@google.com>
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
Cc: brauner@kernel.org, jack@suse.cz, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, sj1557.seo@samsung.com, linux-erofs@lists.ozlabs.org, hch@lst.de
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 31, 2023 at 12:57:58AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728

Hmm, the current linux-next tree does not seem to have that commit ID
any more, and the line numbers don't match up.  I think it is the
WARN_ON for the magic, which could probably be just removed.  I'll
try the reproducers when I find a bit more time.
