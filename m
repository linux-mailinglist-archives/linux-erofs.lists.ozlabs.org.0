Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBD7652CF7
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 07:41:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NcP4N26Slz3c69
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 17:41:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.18; helo=out199-18.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NcP4H2Mcmz3bVK
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Dec 2022 17:41:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VXoU692_1671604901;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VXoU692_1671604901)
          by smtp.aliyun-inc.com;
          Wed, 21 Dec 2022 14:41:42 +0800
Date: Wed, 21 Dec 2022 14:41:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-fscrypt@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [RFC] fs-verity and encryption for EROFS
Message-ID: <Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, Zefan Li <lizefan.x@bytedance.com>, Liu Jiang <gerry@linux.alibaba.com>, Xin Yin <yinxin.x@bytedance.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

(As Eric suggested, I post it on list now..)

In order to outline what we could do next to benefit various image-based
distribution use cases (especially for signed+verified images and
confidential computing), I'd like to discuss two potential new
features for EROFS: verification and encryption.

- Verification

As we're known that currently dm-verity is mainly used for read-only
devices to keep the image integrity.  However, if we consider an
image-based system with lots of shared blobs (no matter they are
device-based or file-based).  IMHO, it'd be better to have an in-band
(rather than a device-mapper out-of-band) approach to verify such blobs.

In particular, currently in container image use cases, an EROFS image
can consist of

  - one meta blob for metadata and filesystem tree;

  - several data-shared blobs with chunk-based de-duplicated data (in
    layers to form the incremental update way; or some other ways like
    one file-one blob)

Currently data blobs can be varied from (typically) dozen blobs to (in
principle) 2^16 - 1 blobs.  dm-verity setup is much hard to cover such
usage but that distribution form is more and more common with the
revolution of containerization.

Also since we have EROFS over fscache infrastructure, file-based
distribution makes dm-verity almost impossible as well. Generally we
could enable underlayfs fs-verity I think, but considering on-demand
lazy pulling from remote, such data may be incomplete before data is
fully downloaded. (I think that is also almost like what Google did
fs-verity for incfs.)  In addition, IMO it's not good if we rely on
features of a random underlay fs with generated tree from random
hashing algorithm and no original signing (by image creator).

My preliminary thought for EROFS on verification is to have blob-based
(or device-based) merkle trees but makes such image integrity
self-contained so that Android, embedded, system rootfs, and container
use cases can all benefit from it.. 

Also as a self-containerd verfication approaches as the other Linux
filesystems, it makes bootloaders and individual EROFS image unpacker
to support/check image integrity and signing easily...

It seems the current fs-verity codebase can almost be well-fitted for
this with some minor modification.  If possible, we could go further
in this way.

- Encryption

I also have some rough preliminary thought for EROFS encryption.
(Although that is not quite in details as verification.)  Currently we
have full-disk encryption and file-based encryption, However, in order
to do finer data sharing between encrypted data (it seems hard to do
finer data de-duplication with file-based encryption), we could also
consider modified convergence encryption, especially for image-based
offline data.

In order to prevent dictionary attack, the key itself may not directly be
derived from its data hashing, but we could assign some random key
relating to specific data as an encrypted chunk and find a way to share
these keys and data in a trusted domain.

The similar thought was also shown in the presentation of AWS Lambda
sparse filesystem, although they don't show much internal details:
https://youtu.be/FTwsMYXWGB0

Anyway, for encryption, it's just a preliminary thought but we're happy
to have a better encryption solution for data sharing for confidential
container images... 

Thanks,
Gao Xiang
