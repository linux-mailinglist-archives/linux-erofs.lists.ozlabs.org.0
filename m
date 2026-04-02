Return-Path: <linux-erofs+bounces-3169-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCKDEmUKzmkwkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3169-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:19:17 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E0E38464B
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:19:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmWsD26yNz2ySk;
	Thu, 02 Apr 2026 17:19:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775110752;
	cv=none; b=ALK5jKtAu2kNs5YFF65O7tqh+R8ZEiXFmLvK8j/7Vpgo8ke5MUBvLFYXGzfPOWr4qQHw7jQsvQGk6QnBeSAGRqwIeAyW+zYh1v6kSq05cq+56hQ/ID1nSn04eqYkclltWU32lcMg9JdKqYcqw9fmOfQlLCr5xy6MaDLn8DCY4vFiIVXqZQIvbLYvBlsIzTQMadMf7jIK7hjQzkrAsw0a3JovWF7GmscsHcqoO9FQbo/lf+31OcUHKcHKjh8BC0QRlbYFL/1YrmfaDrOKelYl+s4skmhkN1+6IPYRic+D9vr5igsTKMfP9JlbEhNSkLtlmDPiaxqZViOyxstO/RqufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775110752; c=relaxed/relaxed;
	bh=bBddbl+SaU/jjf2xKgWWM1steXul5vf2AJGnThfqxy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fUA6etkEb/UfEsNg1S2wZikmE3250I0EW6e9ZuatxTeoizoN61Qh3jaeMpLJrIDzRM9vs708zbxumPk32M9f0CeJT2n79LFqnHlaZOwtT3GnoLYMKqGtiVuzFj3Sr5QeOjw3jcREI2uNCw2vZ8T9oE6r/V4PXF7RLI2vFIYOD3ll6V4qNXkZguFrOwuivuAoskLgjnZXmDaZuRuhbNJy2u5LpgtJq96fTSqbEN1LKnwMz+xcWfpxrij9GRuGrxzVZ/inXH5eaZ5hVNvPShumCBuEPtLyeca6VKtobdzqNcDlvIT+6IVYMTlqAHFCrENWBZSNlhEhTs8x9UoPPx7R+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xTSeDTTo; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xTSeDTTo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmWs84S7wz2xS3
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:19:08 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bBddbl+SaU/jjf2xKgWWM1steXul5vf2AJGnThfqxy4=;
	b=xTSeDTTo8SnQtzVJ88gloEdvVIK94mSe/ot0ZfvvsfRnvYkY5eI4/5LYI2Ae56Q1rwgRng1WQ
	xIZfTMQeEG/mjrqGLVSnxYu1kQmJxOSXErN31jxwRylsbm6UJJBI93acvho5941k/Ux7/Kjds5j
	v0zPpa0JePg5gy333luTSZE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fmWjy718PzLlTb;
	Thu,  2 Apr 2026 14:12:54 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 81ECC40572;
	Thu,  2 Apr 2026 14:19:04 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 14:19:04 +0800
Message-ID: <33f39774-89fd-462c-b260-6ef7ae348cd9@huawei.com>
Date: Thu, 2 Apr 2026 14:19:03 +0800
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs-utils: lib: switch to GPL-2.0+ OR MIT dual
 license
To: <linux-erofs@lists.ozlabs.org>, Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3169-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 79E0E38464B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Yifan Zhao <zhaoyifan28@huawei.com>

On 2026/4/2 14:09, Gao Xiang wrote:
> Apache 2.0 is still too strict for some 3rd-party integration.
>
> Let's switch to GPL-2.0+ OR MIT dual license since we're absolutely
> not working on secret rocket science, so licenses should not be a
> bottleneck to innovation in the Cloud Native and AI era.
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   COPYING                        |   6 +-
>   LICENSES/Apache-2.0            | 186 ---------------------------------
>   include/erofs/atomic.h         |   2 +-
>   include/erofs/bitops.h         |   2 +-
>   include/erofs/blobchunk.h      |   2 +-
>   include/erofs/block_list.h     |   2 +-
>   include/erofs/compress_hints.h |   2 +-
>   include/erofs/config.h         |   2 +-
>   include/erofs/decompress.h     |   2 +-
>   include/erofs/dedupe.h         |   2 +-
>   include/erofs/defs.h           |   2 +-
>   include/erofs/dir.h            |   2 +-
>   include/erofs/diskbuf.h        |   2 +-
>   include/erofs/err.h            |   2 +-
>   include/erofs/exclude.h        |   2 +-
>   include/erofs/importer.h       |   2 +-
>   include/erofs/inode.h          |   2 +-
>   include/erofs/internal.h       |   2 +-
>   include/erofs/io.h             |   2 +-
>   include/erofs/list.h           |   2 +-
>   include/erofs/lock.h           |   2 +-
>   include/erofs/print.h          |   2 +-
>   include/erofs/tar.h            |   2 +-
>   include/erofs/trace.h          |   2 +-
>   include/erofs/workqueue.h      |   2 +-
>   include/erofs/xattr.h          |   2 +-
>   lib/Makefile.am                |   2 +-
>   lib/backends/fanotify.c        |   2 +-
>   lib/backends/nbd.c             |   2 +-
>   lib/base64.c                   |   2 +-
>   lib/bitops.c                   |   2 +-
>   lib/blobchunk.c                |   2 +-
>   lib/block_list.c               |   2 +-
>   lib/cache.c                    |   2 +-
>   lib/compress.c                 |   2 +-
>   lib/compress_hints.c           |   2 +-
>   lib/compressor.c               |   2 +-
>   lib/compressor.h               |   2 +-
>   lib/compressor_deflate.c       |   2 +-
>   lib/compressor_libdeflate.c    |   2 +-
>   lib/compressor_liblzma.c       |   2 +-
>   lib/compressor_libzstd.c       |   2 +-
>   lib/compressor_lz4.c           |   2 +-
>   lib/compressor_lz4hc.c         |   2 +-
>   lib/config.c                   |   2 +-
>   lib/data.c                     |   2 +-
>   lib/decompress.c               |   2 +-
>   lib/dedupe.c                   |   2 +-
>   lib/dedupe_ext.c               |   2 +-
>   lib/dir.c                      |   2 +-
>   lib/diskbuf.c                  |   2 +-
>   lib/exclude.c                  |   2 +-
>   lib/fragments.c                |   2 +-
>   lib/global.c                   |   2 +-
>   lib/gzran.c                    |   2 +-
>   lib/importer.c                 |   2 +-
>   lib/inode.c                    |   2 +-
>   lib/io.c                       |   2 +-
>   lib/kite_deflate.c             |   2 +-
>   lib/liberofs_cache.h           |   2 +-
>   lib/liberofs_compress.h        |   2 +-
>   lib/liberofs_dockerconfig.h    |   2 +-
>   lib/liberofs_fanotify.h        |   2 +-
>   lib/liberofs_fragments.h       |   2 +-
>   lib/liberofs_gzran.h           |   2 +-
>   lib/liberofs_metabox.h         |   2 +-
>   lib/liberofs_nbd.h             |   2 +-
>   lib/liberofs_oci.h             |   2 +-
>   lib/liberofs_private.h         |   2 +-
>   lib/liberofs_rebuild.h         |   2 +-
>   lib/liberofs_s3.h              |   2 +-
>   lib/liberofs_uuid.h            |   2 +-
>   lib/metabox.c                  |   2 +-
>   lib/namei.c                    |   2 +-
>   lib/rebuild.c                  |   2 +-
>   lib/remotes/docker_config.c    |   2 +-
>   lib/remotes/oci.c              |   2 +-
>   lib/remotes/s3.c               |   2 +-
>   lib/rolling_hash.h             |   2 +-
>   lib/sha256.h                   |   2 +-
>   lib/super.c                    |   2 +-
>   lib/tar.c                      |   2 +-
>   lib/uuid.c                     |   2 +-
>   lib/uuid_unparse.c             |   2 +-
>   lib/vmdk.c                     |   2 +-
>   lib/workqueue.c                |   2 +-
>   lib/xattr.c                    |   2 +-
>   lib/zmap.c                     |   2 +-
>   88 files changed, 89 insertions(+), 275 deletions(-)
>   delete mode 100644 LICENSES/Apache-2.0
>
> diff --git a/COPYING b/COPYING
> index 8767cae10b22..e781cc21ff15 100644
> --- a/COPYING
> +++ b/COPYING
> @@ -1,7 +1,7 @@
>   erofs-utils uses two different license patterns:
>   
>    - most liberofs files in `lib` and `include` directories
> -   use GPL-2.0+ OR Apache-2.0 dual license;
> +   use GPL-2.0+ OR MIT dual license;
>   
>    - all other files use GPL-2.0+ license, unless
>      explicitly stated otherwise.
> @@ -9,7 +9,7 @@ erofs-utils uses two different license patterns:
>   Relevant licenses can be found in the LICENSES directory.
>   
>   This model is selected to emphasize that
> -files in `lib` and `include` directory are designed to be included into
> -3rd-party applications, while all other files, are intended to be used
> +files in `lib` and `include` directories are designed to be included in
> +3rd-party applications, while all other files are intended to be used
>   "as is", as part of their intended scenarios, with no intention to
>   support 3rd-party integration use cases.
> diff --git a/LICENSES/Apache-2.0 b/LICENSES/Apache-2.0
> deleted file mode 100644
> index f6c1877fae13..000000000000
> --- a/LICENSES/Apache-2.0
> +++ /dev/null
> @@ -1,186 +0,0 @@
> -Valid-License-Identifier: Apache-2.0
> -SPDX-URL: https://spdx.org/licenses/Apache-2.0.html
> -Usage-Guide:
> -  The Apache-2.0 may only be used for dual-licensed files where the other
> -  license is GPL2 compatible. If you end up using this it MUST be used
> -  together with a GPL2 compatible license using "OR".
> -  To use the Apache License version 2.0 put the following SPDX tag/value
> -  pair into a comment according to the placement guidelines in the
> -  licensing rules documentation:
> -    SPDX-License-Identifier: Apache-2.0
> -License-Text:
> -
> -Apache License
> -
> -Version 2.0, January 2004
> -
> -http://www.apache.org/licenses/
> -
> -TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
> -
> -1. Definitions.
> -
> -"License" shall mean the terms and conditions for use, reproduction, and
> -distribution as defined by Sections 1 through 9 of this document.
> -
> -"Licensor" shall mean the copyright owner or entity authorized by the
> -copyright owner that is granting the License.
> -
> -"Legal Entity" shall mean the union of the acting entity and all other
> -entities that control, are controlled by, or are under common control with
> -that entity. For the purposes of this definition, "control" means (i) the
> -power, direct or indirect, to cause the direction or management of such
> -entity, whether by contract or otherwise, or (ii) ownership of fifty
> -percent (50%) or more of the outstanding shares, or (iii) beneficial
> -ownership of such entity.
> -
> -"You" (or "Your") shall mean an individual or Legal Entity exercising
> -permissions granted by this License.
> -
> -"Source" form shall mean the preferred form for making modifications,
> -including but not limited to software source code, documentation source,
> -and configuration files.
> -
> -"Object" form shall mean any form resulting from mechanical transformation
> -or translation of a Source form, including but not limited to compiled
> -object code, generated documentation, and conversions to other media types.
> -
> -"Work" shall mean the work of authorship, whether in Source or Object form,
> -made available under the License, as indicated by a copyright notice that
> -is included in or attached to the work (an example is provided in the
> -Appendix below).
> -
> -"Derivative Works" shall mean any work, whether in Source or Object form,
> -that is based on (or derived from) the Work and for which the editorial
> -revisions, annotations, elaborations, or other modifications represent, as
> -a whole, an original work of authorship. For the purposes of this License,
> -Derivative Works shall not include works that remain separable from, or
> -merely link (or bind by name) to the interfaces of, the Work and Derivative
> -Works thereof.
> -
> -"Contribution" shall mean any work of authorship, including the original
> -version of the Work and any modifications or additions to that Work or
> -Derivative Works thereof, that is intentionally submitted to Licensor for
> -inclusion in the Work by the copyright owner or by an individual or Legal
> -Entity authorized to submit on behalf of the copyright owner. For the
> -purposes of this definition, "submitted" means any form of electronic,
> -verbal, or written communication sent to the Licensor or its
> -representatives, including but not limited to communication on electronic
> -mailing lists, source code control systems, and issue tracking systems that
> -are managed by, or on behalf of, the Licensor for the purpose of discussing
> -and improving the Work, but excluding communication that is conspicuously
> -marked or otherwise designated in writing by the copyright owner as "Not a
> -Contribution."
> -
> -"Contributor" shall mean Licensor and any individual or Legal Entity on
> -behalf of whom a Contribution has been received by Licensor and
> -subsequently incorporated within the Work.
> -
> -2. Grant of Copyright License. Subject to the terms and conditions of this
> -   License, each Contributor hereby grants to You a perpetual, worldwide,
> -   non-exclusive, no-charge, royalty-free, irrevocable copyright license to
> -   reproduce, prepare Derivative Works of, publicly display, publicly
> -   perform, sublicense, and distribute the Work and such Derivative Works
> -   in Source or Object form.
> -
> -3. Grant of Patent License. Subject to the terms and conditions of this
> -   License, each Contributor hereby grants to You a perpetual, worldwide,
> -   non-exclusive, no-charge, royalty-free, irrevocable (except as stated in
> -   this section) patent license to make, have made, use, offer to sell,
> -   sell, import, and otherwise transfer the Work, where such license
> -   applies only to those patent claims licensable by such Contributor that
> -   are necessarily infringed by their Contribution(s) alone or by
> -   combination of their Contribution(s) with the Work to which such
> -   Contribution(s) was submitted. If You institute patent litigation
> -   against any entity (including a cross-claim or counterclaim in a
> -   lawsuit) alleging that the Work or a Contribution incorporated within
> -   the Work constitutes direct or contributory patent infringement, then
> -   any patent licenses granted to You under this License for that Work
> -   shall terminate as of the date such litigation is filed.
> -
> -4. Redistribution. You may reproduce and distribute copies of the Work or
> -   Derivative Works thereof in any medium, with or without modifications,
> -   and in Source or Object form, provided that You meet the following
> -   conditions:
> -
> -   a. You must give any other recipients of the Work or Derivative Works a
> -      copy of this License; and
> -
> -   b. You must cause any modified files to carry prominent notices stating
> -      that You changed the files; and
> -
> -   c. You must retain, in the Source form of any Derivative Works that You
> -      distribute, all copyright, patent, trademark, and attribution notices
> -      from the Source form of the Work, excluding those notices that do not
> -      pertain to any part of the Derivative Works; and
> -
> -   d. If the Work includes a "NOTICE" text file as part of its
> -      distribution, then any Derivative Works that You distribute must
> -      include a readable copy of the attribution notices contained within
> -      such NOTICE file, excluding those notices that do not pertain to any
> -      part of the Derivative Works, in at least one of the following
> -      places: within a NOTICE text file distributed as part of the
> -      Derivative Works; within the Source form or documentation, if
> -      provided along with the Derivative Works; or, within a display
> -      generated by the Derivative Works, if and wherever such third-party
> -      notices normally appear. The contents of the NOTICE file are for
> -      informational purposes only and do not modify the License. You may
> -      add Your own attribution notices within Derivative Works that You
> -      distribute, alongside or as an addendum to the NOTICE text from the
> -      Work, provided that such additional attribution notices cannot be
> -      construed as modifying the License.
> -
> -    You may add Your own copyright statement to Your modifications and may
> -    provide additional or different license terms and conditions for use,
> -    reproduction, or distribution of Your modifications, or for any such
> -    Derivative Works as a whole, provided Your use, reproduction, and
> -    distribution of the Work otherwise complies with the conditions stated
> -    in this License.
> -
> -5. Submission of Contributions. Unless You explicitly state otherwise, any
> -   Contribution intentionally submitted for inclusion in the Work by You to
> -   the Licensor shall be under the terms and conditions of this License,
> -   without any additional terms or conditions. Notwithstanding the above,
> -   nothing herein shall supersede or modify the terms of any separate
> -   license agreement you may have executed with Licensor regarding such
> -   Contributions.
> -
> -6. Trademarks. This License does not grant permission to use the trade
> -   names, trademarks, service marks, or product names of the Licensor,
> -   except as required for reasonable and customary use in describing the
> -   origin of the Work and reproducing the content of the NOTICE file.
> -
> -7. Disclaimer of Warranty. Unless required by applicable law or agreed to
> -   in writing, Licensor provides the Work (and each Contributor provides
> -   its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS
> -   OF ANY KIND, either express or implied, including, without limitation,
> -   any warranties or conditions of TITLE, NON-INFRINGEMENT,
> -   MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely
> -   responsible for determining the appropriateness of using or
> -   redistributing the Work and assume any risks associated with Your
> -   exercise of permissions under this License.
> -
> -8. Limitation of Liability. In no event and under no legal theory, whether
> -   in tort (including negligence), contract, or otherwise, unless required
> -   by applicable law (such as deliberate and grossly negligent acts) or
> -   agreed to in writing, shall any Contributor be liable to You for
> -   damages, including any direct, indirect, special, incidental, or
> -   consequential damages of any character arising as a result of this
> -   License or out of the use or inability to use the Work (including but
> -   not limited to damages for loss of goodwill, work stoppage, computer
> -   failure or malfunction, or any and all other commercial damages or
> -   losses), even if such Contributor has been advised of the possibility of
> -   such damages.
> -
> -9. Accepting Warranty or Additional Liability. While redistributing the
> -   Work or Derivative Works thereof, You may choose to offer, and charge a
> -   fee for, acceptance of support, warranty, indemnity, or other liability
> -   obligations and/or rights consistent with this License. However, in
> -   accepting such obligations, You may act only on Your own behalf and on
> -   Your sole responsibility, not on behalf of any other Contributor, and
> -   only if You agree to indemnify, defend, and hold each Contributor
> -   harmless for any liability incurred by, or claims asserted against, such
> -   Contributor by reason of your accepting any such warranty or additional
> -   liability.
> -
> -END OF TERMS AND CONDITIONS
> diff --git a/include/erofs/atomic.h b/include/erofs/atomic.h
> index 142590bd6c79..3aa19f6ae369 100644
> --- a/include/erofs/atomic.h
> +++ b/include/erofs/atomic.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2024 Alibaba Cloud
>    */
> diff --git a/include/erofs/bitops.h b/include/erofs/bitops.h
> index 058642f5b190..f407cc95292e 100644
> --- a/include/erofs/bitops.h
> +++ b/include/erofs/bitops.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_BITOPS_H
>   #define __EROFS_BITOPS_H
>   
> diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
> index 48fca63c6c15..1761fdd82432 100644
> --- a/include/erofs/blobchunk.h
> +++ b/include/erofs/blobchunk.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * erofs-utils/lib/blobchunk.h
>    *
> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> index 9d06c9c47d2e..156a5a433ded 100644
> --- a/include/erofs/block_list.h
> +++ b/include/erofs/block_list.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C), 2021, Coolpad Group Limited.
>    * Created by Yue Hu <huyue2@yulong.com>
> diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
> index 6ccc03d213ea..3ab7bb4b67f1 100644
> --- a/include/erofs/compress_hints.h
> +++ b/include/erofs/compress_hints.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
>    * Created by Huang Jianan <huangjianan@oppo.com>
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index bb303c48a0db..95d7e9f16065 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
> index 0d5548327b02..edc017c2b8e4 100644
> --- a/include/erofs/decompress.h
> +++ b/include/erofs/decompress.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
>    * Created by Huang Jianan <huangjianan@oppo.com>
> diff --git a/include/erofs/dedupe.h b/include/erofs/dedupe.h
> index f9caa6113d15..267d9b9f12c8 100644
> --- a/include/erofs/dedupe.h
> +++ b/include/erofs/dedupe.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2022 Alibaba Cloud
>    */
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 71ca11b54ef8..ff87df9d3d51 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/dir.h b/include/erofs/dir.h
> index 5460ac48512f..4e0614dfbbce 100644
> --- a/include/erofs/dir.h
> +++ b/include/erofs/dir.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_DIR_H
>   #define __EROFS_DIR_H
>   
> diff --git a/include/erofs/diskbuf.h b/include/erofs/diskbuf.h
> index 29d9fe2cf52e..122890b2f919 100644
> --- a/include/erofs/diskbuf.h
> +++ b/include/erofs/diskbuf.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_DISKBUF_H
>   #define __EROFS_DISKBUF_H
>   
> diff --git a/include/erofs/err.h b/include/erofs/err.h
> index 59c8c9cc9ae3..7dacc917a4c1 100644
> --- a/include/erofs/err.h
> +++ b/include/erofs/err.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
> index 3f17032b48db..0af39a0a5b05 100644
> --- a/include/erofs/exclude.h
> +++ b/include/erofs/exclude.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Created by Li Guifu <bluce.lee@aliyun.com>
>    */
> diff --git a/include/erofs/importer.h b/include/erofs/importer.h
> index 920488453c34..07e40b47954d 100644
> --- a/include/erofs/importer.h
> +++ b/include/erofs/importer.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2025 Alibaba Cloud
>    */
> diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> index ba62ece9a7cc..bf089e83590b 100644
> --- a/include/erofs/inode.h
> +++ b/include/erofs/inode.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 671880f2db3c..c780228c7bfe 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 9533efc2d20a..96309fde9646 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/list.h b/include/erofs/list.h
> index a7e30ccc4258..e9208887ee80 100644
> --- a/include/erofs/list.h
> +++ b/include/erofs/list.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/lock.h b/include/erofs/lock.h
> index c6e30937aac4..884f23ea739e 100644
> --- a/include/erofs/lock.h
> +++ b/include/erofs/lock.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_LOCK_H
>   #define __EROFS_LOCK_H
>   
> diff --git a/include/erofs/print.h b/include/erofs/print.h
> index a896d75117de..fa979a3a2d46 100644
> --- a/include/erofs/print.h
> +++ b/include/erofs/print.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/include/erofs/tar.h b/include/erofs/tar.h
> index cdaef315442d..a8166336d220 100644
> --- a/include/erofs/tar.h
> +++ b/include/erofs/tar.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_TAR_H
>   #define __EROFS_TAR_H
>   
> diff --git a/include/erofs/trace.h b/include/erofs/trace.h
> index 398e3318355d..fe6734073580 100644
> --- a/include/erofs/trace.h
> +++ b/include/erofs/trace.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
>    */
> diff --git a/include/erofs/workqueue.h b/include/erofs/workqueue.h
> index 36037c381c4a..064246c2bfe4 100644
> --- a/include/erofs/workqueue.h
> +++ b/include/erofs/workqueue.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_WORKQUEUE_H
>   #define __EROFS_WORKQUEUE_H
>   
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index 96546364f316..235688649592 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_XATTR_H
>   #define __EROFS_XATTR_H
>   
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 5f8812f48c93..27bf71094bad 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +# SPDX-License-Identifier: GPL-2.0+ OR MIT
>   
>   noinst_LTLIBRARIES = liberofs.la
>   noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
> diff --git a/lib/backends/fanotify.c b/lib/backends/fanotify.c
> index bbe131ac11c2..cf8b61667705 100644
> --- a/lib/backends/fanotify.c
> +++ b/lib/backends/fanotify.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #define _GNU_SOURCE
>   #include <errno.h>
>   #include <fcntl.h>
> diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
> index da2733477f8e..c488053d99d3 100644
> --- a/lib/backends/nbd.c
> +++ b/lib/backends/nbd.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2025 Alibaba Cloud
>    */
> diff --git a/lib/base64.c b/lib/base64.c
> index a45f7b6f2a1a..623d83cb9f2f 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include "liberofs_base64.h"
>   #include <string.h>
>   
> diff --git a/lib/bitops.c b/lib/bitops.c
> index bb0c9eeb917a..da012b233ac2 100644
> --- a/lib/bitops.c
> +++ b/lib/bitops.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * erofs-utils/lib/bitops.c
>    *
> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> index 96c161b27091..e39bf6800059 100644
> --- a/lib/blobchunk.c
> +++ b/lib/blobchunk.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * erofs-utils/lib/blobchunk.c
>    *
> diff --git a/lib/block_list.c b/lib/block_list.c
> index f8dc9138bd92..e6b28424ad36 100644
> --- a/lib/block_list.c
> +++ b/lib/block_list.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C), 2021, Coolpad Group Limited.
>    * Created by Yue Hu <huyue2@yulong.com>
> diff --git a/lib/cache.c b/lib/cache.c
> index 4c7c3863275b..f964e4737767 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compress.c b/lib/compress.c
> index 4a0d890ae87d..62d2672cb665 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compress_hints.c b/lib/compress_hints.c
> index 322ec97f474a..a4ff0038ebb5 100644
> --- a/lib/compress_hints.c
> +++ b/lib/compress_hints.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
>    * Created by Huang Jianan <huangjianan@oppo.com>
> diff --git a/lib/compressor.c b/lib/compressor.c
> index cf55abcf5359..7593b336ffc8 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compressor.h b/lib/compressor.h
> index 86b45a759874..7b7ef37f8218 100644
> --- a/lib/compressor.h
> +++ b/lib/compressor.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
> index f567d2c731af..9521aec6914d 100644
> --- a/lib/compressor_deflate.c
> +++ b/lib/compressor_deflate.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2023, Alibaba Cloud
>    * Copyright (C) 2023, Gao Xiang <xiang@kernel.org>
> diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
> index 18f5f7b4048c..da39e354974c 100644
> --- a/lib/compressor_libdeflate.c
> +++ b/lib/compressor_libdeflate.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include "erofs/internal.h"
>   #include "erofs/print.h"
>   #include "erofs/config.h"
> diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
> index 49a90a23525a..ac5d02ea00a2 100644
> --- a/lib/compressor_liblzma.c
> +++ b/lib/compressor_liblzma.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2021 Gao Xiang <xiang@kernel.org>
>    */
> diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
> index 6330f445ffa6..06f16c272e80 100644
> --- a/lib/compressor_libzstd.c
> +++ b/lib/compressor_libzstd.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include "erofs/internal.h"
>   #include "erofs/print.h"
>   #include "erofs/config.h"
> diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
> index f3d88b09fa4a..5f3530a7e6f0 100644
> --- a/lib/compressor_lz4.c
> +++ b/lib/compressor_lz4.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
> index 9955c0d717ac..073e33073a3d 100644
> --- a/lib/compressor_lz4hc.c
> +++ b/lib/compressor_lz4hc.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/config.c b/lib/config.c
> index ab7eb01e1914..b7dbced071f7 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/data.c b/lib/data.c
> index 6fd1389cc09f..1bb9269cb836 100644
> --- a/lib/data.c
> +++ b/lib/data.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
>    * Compression support by Huang Jianan <huangjianan@oppo.com>
> diff --git a/lib/decompress.c b/lib/decompress.c
> index e66693c5883e..d23135e0cd43 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
>    * Created by Huang Jianan <huangjianan@oppo.com>
> diff --git a/lib/dedupe.c b/lib/dedupe.c
> index bdd890cc2e82..91ea31cc3ec4 100644
> --- a/lib/dedupe.c
> +++ b/lib/dedupe.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2022 Alibaba Cloud
>    */
> diff --git a/lib/dedupe_ext.c b/lib/dedupe_ext.c
> index d7a9b737e428..ae00bbe5e03d 100644
> --- a/lib/dedupe_ext.c
> +++ b/lib/dedupe_ext.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include "erofs/dedupe.h"
>   #include "liberofs_xxhash.h"
>   #include <stdlib.h>
> diff --git a/lib/dir.c b/lib/dir.c
> index 98edb8e1695c..bf611d9b9678 100644
> --- a/lib/dir.c
> +++ b/lib/dir.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include <stdlib.h>
>   #include <sys/stat.h>
>   #include "erofs/print.h"
> diff --git a/lib/diskbuf.c b/lib/diskbuf.c
> index 0bf42da6a8af..b32a39adf67a 100644
> --- a/lib/diskbuf.c
> +++ b/lib/diskbuf.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include "erofs/diskbuf.h"
>   #include "erofs/internal.h"
>   #include "erofs/print.h"
> diff --git a/lib/exclude.c b/lib/exclude.c
> index 5f6107b24a60..6beb46bc2def 100644
> --- a/lib/exclude.c
> +++ b/lib/exclude.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Created by Li Guifu <bluce.lee@aliyun.com>
>    */
> diff --git a/lib/fragments.c b/lib/fragments.c
> index 0f07e33b3679..13afce3be537 100644
> --- a/lib/fragments.c
> +++ b/lib/fragments.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C), 2022, Coolpad Group Limited.
>    * Created by Yue Hu <huyue2@coolpad.com>
> diff --git a/lib/global.c b/lib/global.c
> index c3d8aec875e9..938aa0a79422 100644
> --- a/lib/global.c
> +++ b/lib/global.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2025 Alibaba Cloud
>    */
> diff --git a/lib/gzran.c b/lib/gzran.c
> index b861c581e408..3973c1f37a75 100644
> --- a/lib/gzran.c
> +++ b/lib/gzran.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2025 Alibaba Cloud
>    */
> diff --git a/lib/importer.c b/lib/importer.c
> index 26c86a0b0098..c404b0f7fadb 100644
> --- a/lib/importer.c
> +++ b/lib/importer.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2025 Alibaba Cloud
>    */
> diff --git a/lib/inode.c b/lib/inode.c
> index 2cfc6c58bda8..c932981a47b7 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/io.c b/lib/io.c
> index 0c5eb2c29989..3ba45ccf8cbd 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
> index 29e44b3b4a92..c1d3c6db7f48 100644
> --- a/lib/kite_deflate.c
> +++ b/lib/kite_deflate.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * erofs-utils/lib/kite_deflate.c
>    *
> diff --git a/lib/liberofs_cache.h b/lib/liberofs_cache.h
> index baac609fb49f..ddaca5497390 100644
> --- a/lib/liberofs_cache.h
> +++ b/lib/liberofs_cache.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2018 HUAWEI, Inc.
>    *             http://www.huawei.com
> diff --git a/lib/liberofs_compress.h b/lib/liberofs_compress.h
> index 4b9dd42f1318..da6eb1a00d9d 100644
> --- a/lib/liberofs_compress.h
> +++ b/lib/liberofs_compress.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/liberofs_dockerconfig.h b/lib/liberofs_dockerconfig.h
> index 1580e1c329e5..6752926a8f58 100644
> --- a/lib/liberofs_dockerconfig.h
> +++ b/lib/liberofs_dockerconfig.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2026 Tencent, Inc.
>    *             http://www.tencent.com/
> diff --git a/lib/liberofs_fanotify.h b/lib/liberofs_fanotify.h
> index 965090ff2f22..6ecc0e26bcbc 100644
> --- a/lib/liberofs_fanotify.h
> +++ b/lib/liberofs_fanotify.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_LIB_LIBEROFS_FANOTIFY_H
>   #define __EROFS_LIB_LIBEROFS_FANOTIFY_H
>   
> diff --git a/lib/liberofs_fragments.h b/lib/liberofs_fragments.h
> index 11833ebc938d..cf549367bc5d 100644
> --- a/lib/liberofs_fragments.h
> +++ b/lib/liberofs_fragments.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2022, Coolpad Group Limited.
>    * Copyright (C) 2025 Alibaba Cloud
> diff --git a/lib/liberofs_gzran.h b/lib/liberofs_gzran.h
> index 443fe1558ac5..fa86cc3a7839 100644
> --- a/lib/liberofs_gzran.h
> +++ b/lib/liberofs_gzran.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2025 Alibaba Cloud
>    */
> diff --git a/lib/liberofs_metabox.h b/lib/liberofs_metabox.h
> index bf4051cf18e2..f966c205d9a2 100644
> --- a/lib/liberofs_metabox.h
> +++ b/lib/liberofs_metabox.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_LIB_LIBEROFS_METABOX_H
>   #define __EROFS_LIB_LIBEROFS_METABOX_H
>   
> diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
> index 78c8af511bec..ec7adbf728d2 100644
> --- a/lib/liberofs_nbd.h
> +++ b/lib/liberofs_nbd.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2025 Alibaba Cloud
>    */
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 3b3d66dd449d..8eec3f720cd1 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2025 Tencent, Inc.
>    *             http://www.tencent.com/
> diff --git a/lib/liberofs_private.h b/lib/liberofs_private.h
> index ebd9e7034860..64bcae83d84c 100644
> --- a/lib/liberofs_private.h
> +++ b/lib/liberofs_private.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   
>   #ifdef HAVE_LIBSELINUX
>   #include <selinux/selinux.h>
> diff --git a/lib/liberofs_rebuild.h b/lib/liberofs_rebuild.h
> index 69802fb9542c..6459dbd42a64 100644
> --- a/lib/liberofs_rebuild.h
> +++ b/lib/liberofs_rebuild.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_LIB_LIBEROFS_REBUILD_H
>   #define __EROFS_LIB_LIBEROFS_REBUILD_H
>   
> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
> index f4886cd4ecf8..c81834785c5f 100644
> --- a/lib/liberofs_s3.h
> +++ b/lib/liberofs_s3.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2025 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/liberofs_uuid.h b/lib/liberofs_uuid.h
> index 63b358a854d4..e8bb1be94fde 100644
> --- a/lib/liberofs_uuid.h
> +++ b/lib/liberofs_uuid.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_LIB_UUID_H
>   #define __EROFS_LIB_UUID_H
>   
> diff --git a/lib/metabox.c b/lib/metabox.c
> index 12706aafdb36..d5ce9e3243b8 100644
> --- a/lib/metabox.c
> +++ b/lib/metabox.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include <stdlib.h>
>   #include "erofs/inode.h"
>   #include "erofs/importer.h"
> diff --git a/lib/namei.c b/lib/namei.c
> index 896e348bc3ee..f19e4b13d69a 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Created by Li Guifu <blucerlee@gmail.com>
>    */
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> index f89a17c44193..7ab2b499923c 100644
> --- a/lib/rebuild.c
> +++ b/lib/rebuild.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #define _GNU_SOURCE
>   #include <unistd.h>
>   #include <stdlib.h>
> diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
> index 00db1bb6dc1d..8e236fca1e33 100644
> --- a/lib/remotes/docker_config.c
> +++ b/lib/remotes/docker_config.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2026 Tencent, Inc.
>    *             http://www.tencent.com/
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index f96be13387a7..80a1e38b1531 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2025 Tencent, Inc.
>    *             http://www.tencent.com/
> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
> index 768232ad0b66..1385e16018cd 100644
> --- a/lib/remotes/s3.c
> +++ b/lib/remotes/s3.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2025 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/lib/rolling_hash.h b/lib/rolling_hash.h
> index 448db34edc1b..cfabfca87109 100644
> --- a/lib/rolling_hash.h
> +++ b/lib/rolling_hash.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   /*
>    * Copyright (C) 2022 Alibaba Cloud
>    */
> diff --git a/lib/sha256.h b/lib/sha256.h
> index 851b80c722d3..6bcf03c26805 100644
> --- a/lib/sha256.h
> +++ b/lib/sha256.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>   #ifndef __EROFS_LIB_SHA256_H
>   #define __EROFS_LIB_SHA256_H
>   
> diff --git a/lib/super.c b/lib/super.c
> index 088c9a01fc2f..6ad27c054333 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Created by Li Guifu <blucerlee@gmail.com>
>    */
> diff --git a/lib/tar.c b/lib/tar.c
> index 599e41342255..87a6a619dd76 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include <unistd.h>
>   #include <stdlib.h>
>   #include <string.h>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 1fae857f2c8d..3b1bd38e63a9 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2023 Norbert Lange <nolange79@gmail.com>
>    */
> diff --git a/lib/uuid_unparse.c b/lib/uuid_unparse.c
> index 3255c4bdd7a5..890acda8ce96 100644
> --- a/lib/uuid_unparse.c
> +++ b/lib/uuid_unparse.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2023 Norbert Lange <nolange79@gmail.com>
>    */
> diff --git a/lib/vmdk.c b/lib/vmdk.c
> index 8080c515bf75..316a8ffc94b2 100644
> --- a/lib/vmdk.c
> +++ b/lib/vmdk.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include "erofs/internal.h"
>   
>   static int erofs_vmdk_desc_add_extent(FILE *f, u64 sectors,
> diff --git a/lib/workqueue.c b/lib/workqueue.c
> index 1f3fa7ca34ed..8c78d7920fe9 100644
> --- a/lib/workqueue.c
> +++ b/lib/workqueue.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   #include <pthread.h>
>   #include <stdlib.h>
>   #include "erofs/print.h"
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 565070a698dc..b11cd3b681ae 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * Copyright (C) 2019 Li Guifu <blucerlee@gmail.com>
>    *                    Gao Xiang <xiang@kernel.org>
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 4a6507726ba8..5b44b60ed586 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>   /*
>    * (a large amount of code was adapted from Linux kernel. )
>    *

