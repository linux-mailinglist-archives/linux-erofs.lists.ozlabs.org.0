Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E529763232
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 11:32:06 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BJaw31GH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9pZX3SXhz3bZF
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 19:32:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BJaw31GH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::f; helo=out-15.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-15.mta0.migadu.com (out-15.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9pZM5yHHz2yV0
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 19:31:53 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690363901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9JATXkXZaN7f0jrXVOoaEMLIPnzZ4EB9BwhBVu88/k=;
	b=BJaw31GHkPVMB5J3bFLk7nCWUXBih3Evut0vs64rGABml16vhPPP+VTCvSpnvcgPtpNdnt
	lUE24RniQLpCmG5kFgpHNW+1PDmB/qhB9l9vhPT5YKqpl2p08nrVkD19PS1VqQI3/KFSOu
	LvMc1Yox7zbU5EqPQ+5oAKbHUZVLA0E=
MIME-Version: 1.0
Subject: Re: [PATCH v2 43/47] mm: shrinker: add a secondary array for
 shrinker_info::{map, nr_deferred}
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230724094354.90817-44-zhengqi.arch@bytedance.com>
Date: Wed, 26 Jul 2023 17:30:53 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <B421DD89-09B5-4488-BEC1-D6F88C6DE75A@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-44-zhengqi.arch@bytedance.com>
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



> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
> Currently, we maintain two linear arrays per node per memcg, which are
> shrinker_info::map and shrinker_info::nr_deferred. And we need to =
resize
> them when the shrinker_nr_max is exceeded, that is, allocate a new =
array,
> and then copy the old array to the new array, and finally free the old
> array by RCU.
>=20
> For shrinker_info::map, we do set_bit() under the RCU lock, so we may =
set
> the value into the old map which is about to be freed. This may cause =
the
> value set to be lost. The current solution is not to copy the old map =
when
> resizing, but to set all the corresponding bits in the new map to 1. =
This
> solves the data loss problem, but bring the overhead of more pointless
> loops while doing memcg slab shrink.
>=20
> For shrinker_info::nr_deferred, we will only modify it under the read =
lock
> of shrinker_rwsem, so it will not run concurrently with the resizing. =
But
> after we make memcg slab shrink lockless, there will be the same data =
loss
> problem as shrinker_info::map, and we can't work around it like the =
map.
>=20
> For such resizable arrays, the most straightforward idea is to change =
it
> to xarray, like we did for list_lru [1]. We need to do xa_store() in =
the
> list_lru_add()-->set_shrinker_bit(), but this will cause memory
> allocation, and the list_lru_add() doesn't accept failure. A possible
> solution is to pre-allocate, but the location of pre-allocation is not
> well determined.
>=20
> Therefore, this commit chooses to introduce a secondary array for
> shrinker_info::{map, nr_deferred}, so that we only need to copy this
> secondary array every time the size is resized. Then even if we get =
the
> old secondary array under the RCU lock, the found map and nr_deferred =
are
> also true, so no data is lost.
>=20
> [1]. =
https://lore.kernel.org/all/20220228122126.37293-13-songmuchun@bytedance.c=
om/
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>


