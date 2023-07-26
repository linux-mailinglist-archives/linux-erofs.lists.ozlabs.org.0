Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F1762C21
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 08:58:50 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h66bJdZf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9l9g6s4xz2ytG
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 16:58:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h66bJdZf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::2f; helo=out-47.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [IPv6:2001:41d0:203:375::2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9l995bzDz3cHH
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 16:58:20 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690354693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJECzEbg6AvUr2F/gs+Gdm9ozTbMv8VDjSGrHUhWzDY=;
	b=h66bJdZfshf2g1RLUpKqwxN7lHNgmJn36kolmPZUX2Aqc09HU6VbZ+x+Z0DjP9YGQTMTaE
	Bmqs9Mr+MJHT0UpOpBW+6O4BcvF6xaU81Xxo7qywI9w5gMUx1fYGe1bTsluzGucfJTYdAa
	elPkOC38C2T6cXpSojcQr4ueQ4x5eAU=
MIME-Version: 1.0
Subject: Re: [PATCH v2 13/47] nfs: dynamically allocate the nfs-acl shrinker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230724094354.90817-14-zhengqi.arch@bytedance.com>
Date: Wed, 26 Jul 2023 14:57:20 +0800
Content-Transfer-Encoding: 7bit
Message-Id: <344A2B0E-8A25-494A-A8E1-5C75441B965D@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-14-zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
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
Cc: kvm@vger.kernel.org, djwong@kernel.org, Roman Gushchin <roman.gushchin@linux.dev>, david@fromorbit.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, yujie.liu@intel.com, Vlastimil Babka <vbabka@suse.cz>, linux-raid@vger.kernel.org, Christian Brauner <brauner@kernel.org>, tytso@mit.edu, Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, netdev <netdev@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foun
 dation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> Use new APIs to dynamically allocate the nfs-acl shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


