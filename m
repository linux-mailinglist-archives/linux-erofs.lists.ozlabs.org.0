Return-Path: <linux-erofs+bounces-1037-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC46B597F8
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Sep 2025 15:43:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cR35K3jT3z2ySY;
	Tue, 16 Sep 2025 23:43:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.88
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758030213;
	cv=none; b=jO+p5nw77I8qIWLfeY8CTpfk83NkzvfjgD8QVEDrJV6nrEVqu5oUxhwmIEEevoxTNT22LWejKMUY5EHjZtdEtpGR4olDrmZHVfv3CyeJ9IU7VkTenuaTySSVdkO+Hy1rqUuk3tPMNoG6jPshOxzni5tIwZe5bfRQRG5mX9K+vVsfoxlAiB3kAC/OCXBM8Qctht8zp+DgZ5HDSfqYg8MnQVB1NYOrqtl2Xko5IO4maytrP6CgiK5m9M9nWqXl/kN64SABoFWQXfCCNc9XyPEs+coxNVcvQjjUgMLgWcJZ2bSOrNNNwfS7GfZ607qiG/3Ui7d/2+KKeIExui2QgAOZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758030213; c=relaxed/relaxed;
	bh=bFRChIop9expb4c6vljim9EJ+1PC2FGVKKLjcnGfs+U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MzwBGCnRcN/iXNgVc4yQHicexztEshs2P8VZGR0rvjtuSbME6BjHdDhOVPy9eO5M4JUDCDl259dn4o8ekscxUSNDYztz/ow+rT7hcgoIubocXNt0Isd7jfxMlHGONF+zrrvyIZvDS8j+YSNVG61mCDrgVi/Dwk8dusUhWrRxuv/mjn+XE8ulthhvpV6JyB2YbdLekABNEyRYX8sHr0SCNICGhgYk+Y4lU1QmLI/Q6/ixHhP2l2HqDylF82RTAELRUeDqZTZXXc617kXFoRzcx+3JM/ND0RzS0oD8EVfBVS3AfA3oQoZe+LzLikeEy0PCJ7UcTowmg7bZEziPqlQisQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.88; helo=out28-88.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.88; helo=out28-88.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-88.mail.aliyun.com (out28-88.mail.aliyun.com [115.124.28.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cR35J0PFnz2yPS
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Sep 2025 23:43:29 +1000 (AEST)
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.egTkdo-_1758030200 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 16 Sep 2025 21:43:21 +0800
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v1 2/2] oci: replace layer index with layer digest
From: hudsonZhu <hudson@cyzhu.com>
In-Reply-To: <1998d562-d40e-44d0-9cd9-42e734de67f1@linux.alibaba.com>
Date: Tue, 16 Sep 2025 21:43:10 +0800
Cc: linux-erofs@lists.ozlabs.org,
 xiang@kernel.org,
 Chengyu Zhu <hudsonzhu@tencent.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <06E91C03-951E-46B5-85C9-8F61F9BDE8EF@cyzhu.com>
References: <20250913082748.88070-1-hudson@cyzhu.com>
 <20250913082748.88070-3-hudson@cyzhu.com>
 <1998d562-d40e-44d0-9cd9-42e734de67f1@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Sure, I=E2=80=99ll make the change to support both layer index and layer =
digest.

Thanks,
Chengyu

> 2025=E5=B9=B49=E6=9C=8815=E6=97=A5 09:50=EF=BC=8CGao Xiang =
<hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Chengyu,
>=20
> On 2025/9/13 16:27, ChengyuZhu6 wrote:
>> From: Chengyu Zhu <hudsonzhu@tencent.com>
>> Replace numeric layer_index with layer_digest string for more precise
>> and reliable OCI layer identification. This change affects both =
mkfs.erofs
>> and mount.erofs tools.
>> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
>=20
> Could we have a way to support both layer index and digest?
>=20
> For users using `mkfs.erofs` or `mount.erofs` directly, I think
> they feel more convenient to use layer index instead.
>=20
> But for snapshotter and failover cases, I think layer digest is
> more suitable.
>=20
> Thanks,
> Gao Xiang


