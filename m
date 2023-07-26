Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A172D762C7F
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 09:05:20 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=USoqEnOQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9lKB3qSSz2ytG
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 17:05:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=USoqEnOQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::c; helo=out-12.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-12.mta1.migadu.com (out-12.mta1.migadu.com [IPv6:2001:41d0:203:375::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9lK73kmmz2yL0
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 17:05:15 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690355108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXYamYs9irq65yhoLRu1td82YuFMeMDqOuwaU+oDyHM=;
	b=USoqEnOQU6eM3+N9zIAHCDwhNC+8+UNIWLHIgerhexBlGJCaVmSRSO1wU4o3mjHNGYO9Rs
	DYRZMApHrS1Pjvb6NJH1mJ50Vk6voJ6kQPH4oorM80xUHt6/RAFEITooiN15iQlceLlIh+
	2SDmjYt2iC3yWxkOb7vPU57vNB82awk=
MIME-Version: 1.0
Subject: Re: [PATCH v2 17/47] rcu: dynamically allocate the rcu-lazy shrinker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230724094354.90817-18-zhengqi.arch@bytedance.com>
Date: Wed, 26 Jul 2023 15:04:30 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A164818-56E1-4EB4-A927-1B2D23B81659@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-18-zhengqi.arch@bytedance.com>
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
Cc: kvm@vger.kernel.org, djwong@kernel.org, Roman Gushchin <roman.gushchin@linux.dev>, david@fromorbit.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, yujie.liu@intel.com, Vlastimil Babka <vbabka@suse.cz>, linux-raid@vger.kernel.org, Christian Brauner <brauner@kernel.org>, tytso@mit.edu, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, senozhatsky@chromium.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@
 ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
> Use new APIs to dynamically allocate the rcu-lazy shrinker.
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> kernel/rcu/tree_nocb.h | 19 +++++++++++--------
> 1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 43229d2b0c44..919f17561733 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1397,12 +1397,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, =
struct shrink_control *sc)
> return count ? count : SHRINK_STOP;
> }
>=20
> -static struct shrinker lazy_rcu_shrinker =3D {
> -	.count_objects =3D lazy_rcu_shrink_count,
> -	.scan_objects =3D lazy_rcu_shrink_scan,
> -	.batch =3D 0,
> -	.seeks =3D DEFAULT_SEEKS,
> -};
> +static struct shrinker *lazy_rcu_shrinker;

Seems there is no users of this variable, maybe we could drop
this.

