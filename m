Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1D40C7E7
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Sep 2021 17:10:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H8kDZ4m22z2yPT
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Sep 2021 01:10:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H8kDR4gG3z2yK7
 for <linux-erofs@lists.ozlabs.org>; Thu, 16 Sep 2021 01:10:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R361e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0UoVAt14_1631718607; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UoVAt14_1631718607) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 15 Sep 2021 23:10:08 +0800
Date: Wed, 15 Sep 2021 23:10:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: tests: check the compress-hints functionality
Message-ID: <YUIMzksibSPZE7tR@B-P7TQMD6M-0146.local>
References: <20210907001250.GD23541@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20210915112149.25073-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210915112149.25073-1-huangjianan@oppo.com>
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
Cc: yh@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


Jianan,

On Wed, Sep 15, 2021 at 07:21:49PM +0800, Huang Jianan via Linux-erofs wrote:
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Thanks for this! I'm fine with the patch, let me fold some
random modification as well.

> ---
>  tests/Makefile.am   |  5 ++-
>  tests/common/rc     |  2 +-
>  tests/erofs/017     | 78 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/erofs/017.out |  2 ++
>  4 files changed, 85 insertions(+), 2 deletions(-)
>  create mode 100755 tests/erofs/017
>  create mode 100644 tests/erofs/017.out
> 
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 1d73a1b..632dcf5 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -70,9 +70,12 @@ TESTS += erofs/014
>  # 015 - regression test for battach on full buffer block
>  TESTS += erofs/015
>  
> -# 006 - verify the uncompressed image with 2-level random files
> +# 016 - verify the uncompressed image with 2-level random files
>  TESTS += erofs/016
>  
> +# 017 - check the compress-hints functionality
> +TESTS += erofs/017
> +
>  EXTRA_DIST = common/rc erofs
>  
>  clean-local: clean-local-check
> diff --git a/tests/common/rc b/tests/common/rc
> index a6b6014..abd88d1 100644
> --- a/tests/common/rc
> +++ b/tests/common/rc
> @@ -185,7 +185,7 @@ _scratch_cycle_mount()
>  
>  _get_filesize()
>  {
> -    stat -c %s "$1"
> +	stat -c %s "$1"
>  }
>  
>  _require_fssum()
> diff --git a/tests/erofs/017 b/tests/erofs/017
> new file mode 100755
> index 0000000..a12d1ad
> --- /dev/null
> +++ b/tests/erofs/017
> @@ -0,0 +1,78 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +
> +# get standard environment, filters and checks
> +. "${srcdir}/common/rc"
> +
> +cleanup()
> +{
> +	cd /
> +	rm -rf $tmp.*
> +}
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +echo "QA output created by $seq"
> +
> +[ -z "$lz4hc_on" ] && \
> +	_notrun "lz4hc compression is disabled, skipped."
> +
> +if [ -z $SCRATCH_DEV ]; then
> +	SCRATCH_DEV=$tmp/erofs_$seq.img
> +	rm -f SCRATCH_DEV
> +fi
> +
> +localdir="$tmp/$seq"
> +rm -rf $localdir
> +mkdir -p $localdir
> +
> +# collect files pending for verification
> +dirs=`find ../ -maxdepth 1 -type d -printf '%p:'`
> +IFS=':'
> +for d in $dirs; do
> +	[ $d = '../' ] && continue
> +	[ -z "${d##\.\./tests*}" ] && continue
> +	[ -z "${d##\.\./\.*}" ] && continue
> +	cp -nR $d $localdir
> +done
> +unset IFS
> +
> +# init compress_hints
> +compress_hints="$tmp/compress_hints"
> +rm -rf $compress_hints
> +# ignore warning
> +MKFS_OPTIONS="${MKFS_OPTIONS} -d1 -zlz4hc --compress-hints=$compress_hints"
> +
> +echo "0" > $compress_hints
> +_scratch_mkfs $localdir && \
> +	_fail "successfully mkfs with invalid compress_hints"
> +
> +echo "0        \.c$"  >  $compress_hints
> +echo "1048577  \.am$" >> $compress_hints
> +echo "8192     \.h$"  >> $compress_hints
> +_scratch_mkfs $localdir || _fail "failed to mkfs"
> +
> +# verify lz4hc compressed image
> +_require_erofs
> +_require_fssum
> +
> +_scratch_mount 2>>$seqres.full
> +
> +FSSUM_OPTS="-MAC"
> +[ $FSTYP = "erofsfuse" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
> +
> +sum1=`$FSSUM_PROG $FSSUM_OPTS $localdir`
> +echo "$localdir checksum is $sum1" >>$seqres.full
> +sum2=`$FSSUM_PROG $FSSUM_OPTS $SCRATCH_MNT`
> +echo "$SCRATCH_MNT checksum is $sum2" >>$seqres.full
> +
> +[ "x$sum1" = "x$sum2" ] || _fail "-->checkMD5 FAILED"
> +_scratch_unmount
> +
> +echo Silence is golden
> +status=0
> +exit 0
> diff --git a/tests/erofs/017.out b/tests/erofs/017.out
> new file mode 100644
> index 0000000..8222844
> --- /dev/null
> +++ b/tests/erofs/017.out
> @@ -0,0 +1,2 @@
> +QA output created by 017
> +Silence is golden
> -- 
> 2.25.1
