Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C7C74540A
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 05:03:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvW2T0X63z30h7
	for <lists+linux-erofs@lfdr.de>; Mon,  3 Jul 2023 13:03:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QvW2N6ZF8z2yyT
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Jul 2023 13:03:07 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmRG-Mf_1688353380;
Received: from 30.97.48.250(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmRG-Mf_1688353380)
          by smtp.aliyun-inc.com;
          Mon, 03 Jul 2023 11:03:01 +0800
Message-ID: <9862c0f5-aeeb-9bfa-889c-ec789cd82f1a@linux.alibaba.com>
Date: Mon, 3 Jul 2023 11:03:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs-utils: Provide identical functionality without
 libuuid
To: Norbert Lange <nolange79@gmail.com>
References: <20230702101907.5081-1-nolange79@gmail.com>
 <b737bdff-9f90-e8cc-84b5-a6ee24ef291b@linux.alibaba.com>
 <CADYdroNuhDhbK029bP04NUVReyf2_vOjLAAPN_a4we8eD_fSAA@mail.gmail.com>
In-Reply-To: <CADYdroNuhDhbK029bP04NUVReyf2_vOjLAAPN_a4we8eD_fSAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, Huang Jianan <huangjianan@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/3 06:16, Norbert Lange wrote:
> Am So., 2. Juli 2023 um 13:07 Uhr schrieb Gao Xiang
> <hsiangkao@linux.alibaba.com>:
>>
>> Hi Norbert,
>>
>> On 2023/7/2 18:19, Norbert Lange wrote:
>>> The motivation is to have standalone (statically linked) erofs binaries
>>> for simple initrd images, that are nevertheless able to (re)create
>>> erofs images with a given UUID.
>>>
>>> For this reason a few of libuuid functions have implementations added
>>> directly in erofs-utils.
>>> A header liberofs_uuid.h provides the new functions, which are
>>> always available. A further sideeffect is that code can be simplified
>>> which calls into this functionality.
>>>
>>> The uuid_unparse function replacement is always a private
>>> implementation and split into its own file, this further restricts
>>> the (optional) dependency on libuuid only to the erofs-mkfs tool.
>>>
>>> Signed-off-by: Norbert Lange <nolange79@gmail.com>
>>
>> Yeah, overall it looks good to me, some minor nits as below:
>>
>> (Also currently UUID makes the image nonreproducable, I wonder if we
>>    could use some image hash to calculate the whole UUID instead...)
> 
> Not the usecase I am after, I need to use an already known UUID for
> mounting, even if the content changed.

Okay.

> 
>>
>>> ---
>>>    dump/Makefile.am    |   2 +-
>>>    dump/main.c         |   8 +---
>>>    fsck/Makefile.am    |   2 +-
>>>    lib/Makefile.am     |   4 +-
>>>    lib/liberofs_uuid.h |   9 ++++
>>>    lib/uuid.c          | 106 ++++++++++++++++++++++++++++++++++++++++++++
>>>    lib/uuid_unparse.c  |  21 +++++++++
>>>    mkfs/Makefile.am    |   6 +--
>>>    mkfs/main.c         |  21 ++-------
>>>    9 files changed, 149 insertions(+), 30 deletions(-)
>>>    create mode 100644 lib/liberofs_uuid.h
>>>    create mode 100644 lib/uuid.c
>>>    create mode 100644 lib/uuid_unparse.c
>>>
>>> diff --git a/dump/Makefile.am b/dump/Makefile.am
>>> index c2bef6d..90227a5 100644
>>> --- a/dump/Makefile.am
>>> +++ b/dump/Makefile.am
>>> @@ -7,4 +7,4 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
>>>    dump_erofs_SOURCES = main.c
>>>    dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
>>>    dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
>>> -     ${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
>>> +     ${liblz4_LIBS} ${liblzma_LIBS}
>>> diff --git a/dump/main.c b/dump/main.c
>>> index bc4e028..40af09f 100644
>>> --- a/dump/main.c
>>> +++ b/dump/main.c
>>> @@ -17,10 +17,8 @@
>>>    #include "erofs/compress.h"
>>>    #include "erofs/fragments.h"
>>>    #include "../lib/liberofs_private.h"
>>> +#include "../lib/liberofs_uuid.h"
>>>
>>> -#ifdef HAVE_LIBUUID
>>> -#include <uuid.h>
>>> -#endif
>>>
>>>    struct erofsdump_cfg {
>>>        unsigned int totalshow;
>>> @@ -620,9 +618,7 @@ static void erofsdump_show_superblock(void)
>>>                if (feat & feature_lists[i].flag)
>>>                        fprintf(stdout, "%s ", feature_lists[i].name);
>>>        }
>>> -#ifdef HAVE_LIBUUID
>>> -     uuid_unparse_lower(sbi.uuid, uuid_str);
>>> -#endif
>>> +     erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
>>>        fprintf(stdout, "\nFilesystem UUID:                              %s\n",
>>>                        uuid_str);
>>>    }
>>> diff --git a/fsck/Makefile.am b/fsck/Makefile.am
>>> index e6a1fb6..4176d86 100644
>>> --- a/fsck/Makefile.am
>>> +++ b/fsck/Makefile.am
>>> @@ -7,4 +7,4 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
>>>    fsck_erofs_SOURCES = main.c
>>>    fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
>>>    fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
>>> -     ${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
>>> +     ${liblz4_LIBS} ${liblzma_LIBS}
>>> diff --git a/lib/Makefile.am b/lib/Makefile.am
>>> index faa7311..e243c1c 100644
>>> --- a/lib/Makefile.am
>>> +++ b/lib/Makefile.am
>>> @@ -29,9 +29,9 @@ noinst_HEADERS += compressor.h
>>>    liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
>>>                      namei.c data.c compress.c compressor.c zmap.c decompress.c \
>>>                      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
>>> -                   fragments.c rb_tree.c dedupe.c
>>> +                   fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c
>>>
>>> -liberofs_la_CFLAGS = -Wall -I$(top_srcdir)/include
>>> +liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
>>>    if ENABLE_LZ4
>>>    liberofs_la_CFLAGS += ${LZ4_CFLAGS}
>>>    liberofs_la_SOURCES += compressor_lz4.c
>>> diff --git a/lib/liberofs_uuid.h b/lib/liberofs_uuid.h
>>> new file mode 100644
>>> index 0000000..d156699
>>> --- /dev/null
>>> +++ b/lib/liberofs_uuid.h
>>> @@ -0,0 +1,9 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>>> +#ifndef __EROFS_LIB_UUID_H
>>> +#define __EROFS_LIB_UUID_H
>>> +
>>> +void erofs_uuid_generate(unsigned char *out);
>>> +void erofs_uuid_unparse_lower(const unsigned char *buf, char *out);
>>> +int erofs_uuid_parse(const char *in, unsigned char *uu);
>>> +
>>> +#endif
>>> \ No newline at end of file
>>> diff --git a/lib/uuid.c b/lib/uuid.c
>>> new file mode 100644
>>> index 0000000..acff81a
>>> --- /dev/null
>>> +++ b/lib/uuid.c
>>> @@ -0,0 +1,106 @@
>>> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
>>> +/*
>>> + * Copyright (C) 2023 Norbert Lange <nolange79@gmail.com>
>>> + */
>>> +
>>> +#include <string.h>
>>> +#include <errno.h>
>>> +
>>> +#include "erofs/config.h"
>>> +#include "erofs/defs.h"
>>> +#include "liberofs_uuid.h"
>>> +
>>> +#ifdef HAVE_LIBUUID
>>> +#include <uuid.h>
>>> +#else
>>> +
>>> +#include <stdlib.h>
>>> +#include <sys/random.h>
>>> +
>>> +/* Flags to be used, will be modified if kernel does not support them */
>>> +static unsigned erofs_grnd_flag =
>>
>> Could we switch to "unsigned int" for this?
> 
> Sure
> 
>>
>>> +#ifdef GRND_INSECURE
>>> +    GRND_INSECURE;
>>> +#else
>>> +    0x0004;
>>> +#endif
>>> +
>>> +static int s_getrandom(void *pUid, unsigned size, bool insecure)
>>> +{
>>> +    unsigned kflags = erofs_grnd_flag;
>>> +    unsigned flags = insecure ? kflags : 0;
>>
>> same here.
>>
>> Otherwise it looks good to me.
> 
> Found few a formatting inconsistencies as well, already fixed this locally.
> Guess I will wait a bit more for feedback before posting a v2? Not sure
> whats the proper order.

Looks good to me, yet erofs-utils has rare people to work on reviewing,
I'm fine with either way.

Thanks,
Gao Xiang
