Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB331AC55
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Feb 2021 15:37:33 +0100 (CET)
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DdCd71dZVzDwpS
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Feb 2021 01:37:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DdCcr1QSgzDwnf
 for <linux-erofs@lists.ozlabs.org>; Sun, 14 Feb 2021 01:37:09 +1100 (AEDT)
Received: from laptop (unknown [10.1.128.64])
 by front (Coremail) with SMTP id AWSowAC3vODh4ydgx1BnAg--.39828S3;
 Sat, 13 Feb 2021 22:36:22 +0800 (CST)
Date: Sat, 13 Feb 2021 22:36:36 +0800
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v3] erofs-utils: fuse: fix random readlink error
Message-ID: <20210213143636.GA783545@laptop>
References: <20210123152213.GB3167351@xiangao.remote.csb>
 <20210129180747.67731-1-sehuww@mail.scut.edu.cn>
 <20210209193845.GA13059@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209193845.GA13059@hsiangkao-HP-ZHAN-66-Pro-G1>
X-CM-TRANSID: AWSowAC3vODh4ydgx1BnAg--.39828S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW3Gr47Kw4xKFW7Jry3XFb_yoWfZwc_G3
 97J3ykX3y5Wa1xCa15WFZ0vrZxKa17ur10yrn0ka9xZF13X3yava1kArZ3twnxXa18ZFZI
 9Fn0vFyxCry3WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbFxYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
 0_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
 6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jeXdbUUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAKBlepTBEOxgABsn
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 10, 2021 at 03:38:50AM +0800, Gao Xiang wrote:

...

> From bfbd8ee056aca57a77034b8723f3f828f806747b Mon Sep 17 00:00:00 2001
> From: Hu Weiwen <sehuww@mail.scut.edu.cn>
> Date: Sat, 30 Jan 2021 02:07:47 +0800
> Subject: [PATCH v3] erofs-utils: fuse: fix random readlink error
> 
> readlink should fill a **null-terminated** string in the buffer [1].
> 
> To achieve this:
> 1) memset(0) for unmapped extents;
> 2) make erofsfuse_read() properly returning the actual bytes read;
> 3) insert a null character if the path is truncated.
> 
> [1] https://lore.kernel.org/r/20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

It looks good. I've run this patched version against previously failing tests.

Also now I understand the purpose of erofs_map_blocks_flatmode() better.

Thanks,
Hu Weiwen

