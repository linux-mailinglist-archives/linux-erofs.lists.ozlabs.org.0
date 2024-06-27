Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E4491A478
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 13:03:33 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iuU7sbDB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8wfS33k1z3cVb
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 21:03:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iuU7sbDB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8wfP4tKHz30V7
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 21:03:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 07F4061E10;
	Thu, 27 Jun 2024 11:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E3EC2BBFC;
	Thu, 27 Jun 2024 11:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719486204;
	bh=pOlbY4TR3IBReDqvZhVpsrU0lbvhGXcs7UDZyAM6v4A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iuU7sbDBICFPlufbmDZWKVO5QASkRQzqGE2gBZYFlECJ3Bvksqhhfgo9ggVI6hlvU
	 /oWbaEbOXMcRDGfp/mqMjNJNHamwuW8xMPJHMcc08fxpL/aw2uzNSDp2vSUr/SGMa8
	 dPuo/NIUrKb0oGOmcYttdBQ//g3Bu/TLwXqWrzX5mX90VamKUhSXgz38r9gWYUxSGY
	 65NgrnaYJN+iK9cOx/SgNu0kLHt/oVU3MT/uUHFaTfbL+7VLpeuiq0AP1HNnnte9rO
	 1QKOr7z9HJ5X+taRKIz243lPTvVnnj83AdAkT2+zNfK9TJO1cF2uxpY7E0ONsyJowl
	 ghnyWNCkLhauw==
Message-ID: <282dccdf55267a1de5965ff43fa30df8b815b790.camel@kernel.org>
Subject: Re: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send
 req/poll
From: Jeff Layton <jlayton@kernel.org>
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com
Date: Thu, 27 Jun 2024 07:03:22 -0400
In-Reply-To: <20240515125136.3714580-1-libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2024-05-15 at 20:51 +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
>=20
> Hi all!
>=20
> This is the second version of this patch series. Thank you, Jia Zhu and
> Gao Xiang, for the feedback in the previous version.
>=20
> We've been testing ondemand mode for cachefiles since January, and we're
> almost done. We hit a lot of issues during the testing period, and this
> patch set fixes some of the issues related to reopen worker/send req/poll=
.
> The patches have passed internal testing without regression.
>=20
> Patch 1-3: A read request waiting for reopen could be closed maliciously
> before the reopen worker is executing or waiting to be scheduled. So
> ondemand_object_worker() may be called after the info and object and even
> the cache have been freed and trigger use-after-free. So use
> cancel_work_sync() in cachefiles_ondemand_clean_object() to cancel the
> reopen worker or wait for it to finish. Since it makes no sense to wait
> for the daemon to complete the reopen request, to avoid this pointless
> operation blocking cancel_work_sync(), Patch 1 avoids request generation
> by the DROPPING state when the request has not been sent, and Patch 2
> flushes the requests of the current object before cancel_work_sync().
>=20
> Patch 4: Cyclic allocation of msg_id to avoid msg_id reuse misleading
> the daemon to cause hung.
>=20
> Patch 5: Hold xas_lock during polling to avoid dereferencing reqs causing
> use-after-free. This issue was triggered frequently in our tests, and we
> found that anolis 5.10 had fixed it, so to avoid failing the test, this
> patch was pushed upstream as well.
>=20
> Comments and questions are, as always, welcome.
> Please let me know what you think.
>=20
> Thanks,
> Baokun
>=20
> Changes since v1:
> =C2=A0 * Collect RVB from Jia Zhu and Gao Xiang.(Thanks for your review!)
> =C2=A0 * Pathch 1,2=EF=BC=9AAdd more commit messages.
> =C2=A0 * Pathch 3=EF=BC=9AAdd Fixes tag as suggested by Jia Zhu.
> =C2=A0 * Pathch 4=EF=BC=9ANo longer changing "do...while" to "retry" to f=
ocus changes
> =C2=A0=C2=A0=C2=A0 and optimise commit messages.
> =C2=A0 * Pathch 5: Drop the internal RVB tag.
>=20
> [V1]: https://lore.kernel.org/all/20240424033409.2735257-1-libaokun@huawe=
icloud.com
>=20
> Baokun Li (3):
> =C2=A0 cachefiles: stop sending new request when dropping object
> =C2=A0 cachefiles: flush all requests for the object that is being droppe=
d
> =C2=A0 cachefiles: cyclic allocation of msg_id to avoid reuse
>=20
> Hou Tao (1):
> =C2=A0 cachefiles: flush ondemand_object_worker during clean object
>=20
> Jingbo Xu (1):
> =C2=A0 cachefiles: add missing lock protection when polling
>=20
> =C2=A0fs/cachefiles/daemon.c=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0fs/cachefiles/internal.h |=C2=A0 3 +++
> =C2=A0fs/cachefiles/ondemand.c | 52 +++++++++++++++++++++++++++++++++++--=
---
> =C2=A03 files changed, 51 insertions(+), 8 deletions(-)
>=20

The set itself looks fairly straightforward, but I don't know this code
well enough to give it a proper review.

Acked-by: Jeff Layton <jlayton@kernel.org>
