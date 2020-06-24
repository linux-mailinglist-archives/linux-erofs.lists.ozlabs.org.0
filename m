Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0861207EB3
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2020 23:36:42 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49sc0m0yWzzDqkq
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2020 07:36:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.81;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YBQvROBa; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YBQvROBa; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49sbP46tSzzDqZB
 for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jun 2020 07:09:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593032950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2pN8y8R4hyWs50K8WtCaXoEyYKs6iO9bl9vkpzCFH6Q=;
 b=YBQvROBaBd/50XvK91a/gnNzlirlMr6wq2zNmgeCsJx0ZbDxpb71PJGe8Z4HDg8WAg1F1j
 EEARgAZtROMN7AaDgKhz9OKGZG/5tSYYbBLM+rFK7TeTePLCPF04GTFtSWfL9yrGM85+E2
 BLmobFzEpqozDwmR0GhloCSIR5iqN5Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593032950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2pN8y8R4hyWs50K8WtCaXoEyYKs6iO9bl9vkpzCFH6Q=;
 b=YBQvROBaBd/50XvK91a/gnNzlirlMr6wq2zNmgeCsJx0ZbDxpb71PJGe8Z4HDg8WAg1F1j
 EEARgAZtROMN7AaDgKhz9OKGZG/5tSYYbBLM+rFK7TeTePLCPF04GTFtSWfL9yrGM85+E2
 BLmobFzEpqozDwmR0GhloCSIR5iqN5Q=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-5FRZvebVM86yIA97rX_zXQ-1; Wed, 24 Jun 2020 17:09:07 -0400
X-MC-Unique: 5FRZvebVM86yIA97rX_zXQ-1
Received: by mail-pj1-f70.google.com with SMTP id t12so1343968pju.8
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2020 14:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=2pN8y8R4hyWs50K8WtCaXoEyYKs6iO9bl9vkpzCFH6Q=;
 b=DQU9pMkSyHSjuZvNEtakGJvJ2Xo5h512tK6xluZE3zYrS22Af14Xu2dZFgGn8WX5P5
 W7xB/Wv+cQDAo8UbPb7kJbkZPLm52GZwTjcK0WwGSh12/Oi/hsXD2gzvDWkPw9j7deJ6
 58rTxZJajArl9yojWxQR4x7MpzP1BnUk7P+428LRg77CqoLpTxS4X/0vWzfptwIL8+Az
 NWIyr0htHYBm2dvZZYoOFNclAl6vnTBxA8jGr9psIqlfVl6um+b0SHRoeuOW4uA/pe5J
 XdizYiLcxHPRCNaiqle4qpJE41e+6Raw6AipOSr+dVJWPGWWx0vvnHnw88e6O6jZlAED
 t8Iw==
X-Gm-Message-State: AOAM530u7Gw0zH7Yx1C2ya2EjEAk19O/J+bc4uWIDFTDheTz7hTDYkQQ
 5/e/bRPkdbsxWbZSIXWPOtbg2NjwrFiFuW1XWTn9j9jDsDr/tzYkWkhfH5+L7v9j1HoZlS/S3FD
 1XSyQjlARiuoLsDuI/gSyvcD9
X-Received: by 2002:a63:d10a:: with SMTP id k10mr5986030pgg.382.1593032946571; 
 Wed, 24 Jun 2020 14:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgphoFym365/PDSVJrFVtTszek0PwA+6CWAQZQWOuLi3upr+pG1TtMXtwnMnzAZq6bTP4C2Q==
X-Received: by 2002:a63:d10a:: with SMTP id k10mr5985995pgg.382.1593032946284; 
 Wed, 24 Jun 2020 14:09:06 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a12sm21038739pfr.44.2020.06.24.14.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 14:09:05 -0700 (PDT)
Date: Thu, 25 Jun 2020 05:08:53 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs fixes for 5.8-rc3
Message-ID: <20200624210853.GA6242@xiangao.remote.csb>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.8-rc3?

1 bugfix patch addresses regression recently reported by
a vendor with specific compiler options. Need to fix it
in this cycle.

This commit has been in -next (since next-20200621) and
tested without strange happening.

Thanks,
Gao Xiang


The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.8-rc3-fixes

for you to fetch changes up to 3c597282887fd55181578996dca52ce697d985a5:

  erofs: fix partially uninitialized misuse in z_erofs_onlinepage_fixup (2020-06-24 09:47:44 +0800)

----------------------------------------------------------------
Changes since last update:

Fix a regression which uses potential uninitialized
high 32-bit value unexpectedly recently observed with
specific compiler options.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix partially uninitialized misuse in z_erofs_onlinepage_fixup

 fs/erofs/zdata.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

