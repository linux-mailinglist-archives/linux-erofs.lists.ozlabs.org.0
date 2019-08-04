Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ADC80B7E
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 17:42:15 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461lWm2jdlzDqbx
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2019 01:42:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vr9nTIdC"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461lWg69WVzDqWq
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Aug 2019 01:42:05 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id c2so35443921plz.13
 for <linux-erofs@lists.ozlabs.org>; Sun, 04 Aug 2019 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=B5GPSS+cdMlX8fdUKUQgHBWOJ2jdESC8YoXx0g4pq9Q=;
 b=Vr9nTIdCYDlMFZIs5gLghOyajKBH2tB+HJztqHPBQiZVFxM0AZ/JjFlH6r5EaI6IX9
 XMZBu3ChQ/36u6MCZfXq1ikVfjJiSJndx+sYGWvnmpsbWwgkdE3U0uvYyW029Z638nNm
 thbEHCkK/YB8OK8hYFKSTm6GKfDBUvMSsI5GTrzDPhHmT6/f+aWKp8aU702UhrTO2Uvb
 lcZSpRf2BVy5cv3f1UYTV6LdjZpM0Ew0B4r0cYFol+8V28xofrj9kKC3L7qa9p4Thpij
 nOECTNjEVxZKGwiA07cXSRuL5UPUBGWhwI2W2CFtMOTY71jaQg8KB+mv1i4QXWVRKW/n
 cLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=B5GPSS+cdMlX8fdUKUQgHBWOJ2jdESC8YoXx0g4pq9Q=;
 b=KmlMJW/5edSv1iTFjTxCkN0ZglfTngPcLE0Sxm0s0BzaLHLAJdQD+10d6PN9xKZlTg
 Aya2OCWzlXgJHqcc3mjADjGR4TrWLRR1+QjDG8zmzteMe24DlCR5TnNbHWGUEOkVMbWt
 PQu5yH1f1Ypkk5WfPMGjAFAvtThATQ8I+TrOtgESmLQ+xEbLWHfY+elxosIQQ4sYLcrD
 /7Yd5XmIPNZYB4PI0+ALP4vqKWNuPGWOe2U6Uk6rQwClhfHsrxH7w5q60MsIGWV8DOwo
 gR9qfba5QR9sEe5L+VyoVapjbfD5++5dYl35ReckwoPia/zG06SxmuP6Ql48FyLeWzKp
 odEw==
X-Gm-Message-State: APjAAAV4K6fFl4stUwK5P1FMw3W2LnnOqOnIJICs1UlRuKfMh/f9LVJj
 b/SbijNq8BK47msKRPQt9wG3YxJWhv8=
X-Google-Smtp-Source: APXvYqxk3uC56ldFWBORZac6mNKHuZJEvz9Ln87Lk1JR1KNuIPHObc8BXFXapum5jDcdrFPwWktp8A==
X-Received: by 2002:a17:902:e20c:: with SMTP id
 ce12mr14393128plb.130.1564933319504; 
 Sun, 04 Aug 2019 08:41:59 -0700 (PDT)
Received: from [0.0.0.0] (li1129-7.members.linode.com. [45.79.30.7])
 by smtp.gmail.com with ESMTPSA id s12sm80592617pgr.79.2019.08.04.08.41.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Aug 2019 08:41:59 -0700 (PDT)
Subject: Re: [PATCH v2] erofs-utils: code for handling incorrect debug level.
To: Gao Xiang <hsiangkao@aol.com>
References: <20190804081943.20666-1-pratikshinde320@gmail.com>
 <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czRmt9X7yPmhj=7umo3wPoAt3Z_V2hYGV==kb2eohy2Skw@mail.gmail.com>
 <20190804113130.GA3993@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSs3jPuQGqHsravmR9ta0qyQUsP9pah7XieQzjj8Rz5uw@mail.gmail.com>
 <c07418b2-f8d7-8e9a-487b-99ffb1d18ad5@gmail.com>
 <20190804152547.GB6233@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <08f63a50-105c-d97a-8db1-db486e9616a2@gmail.com>
Date: Sun, 4 Aug 2019 23:41:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190804152547.GB6233@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

GAO
	it's a good suggest, you're right

ÔÚ 2019/8/4 23:25, Gao Xiang Ð´µÀ:
> Hi Guifu,
> 
> On Sun, Aug 04, 2019 at 08:57:58PM +0800, Li Guifu wrote:
>> Shinde and Gao
>>   Does the variable name of debug level use another name ? like d ?
>>   The i is usual a temporary increase or decrease self variable.
> 
> I think we can use a common varible name in order to avoid
> too many temporary variables, maybe `i' is not the best
> naming, but `i' also stands for "a integer".
> 
> Maybe we can give a better naming? can you name it and
> submit another patch? I personally don't like define too
> many used-once variables... How do you think?
> 
> Thanks,
> Gao Xiang
> 
>>
>> ?? 2019/8/4 19:39, Pratik Shinde ????:
>>> Hi Gao,
>>>
>>> I Agree with your suggestion. Thanks for the additional code change. I
>>> think thats pretty much our final patch. :)
>>>
>>> -Pratik
>>>
>>> On Sun, 4 Aug, 2019, 5:01 PM Gao Xiang, <hsiangkao@gmx.com> wrote:
>>>
>>>> Hi Pratik,
>>>>
>>>> On Sun, Aug 04, 2019 at 04:03:49PM +0530, Pratik Shinde wrote:
>>>>> Hi Gao,
>>>>>
>>>>> I used fprintf here because we are printing this error message in case of
>>>>> invalid 'cfg.c_dbg_lvl'. Hence I thought
>>>>> we cannot rely on erofs_err().
>>>>> e.g
>>>>> $ mkfs.erofs -d -1 <erofs image> <directory>
>>>>> In this case debug level is '-1' which is invalid.If we try to print the
>>>>> error message using erofs_err() with c_dbg_lvl = -1,
>>>>> it will not print anything.
>>>>
>>>> Yes, so c_dbg_lvl should be kept in default level (0) before
>>>> checking its vaildity I think.
>>>>
>>>>> While applying the minor fixup, just reset the c_dbg_lvl to 0 , so that
>>>>> erofs_err() will be able to log the error message.
>>>>
>>>> Since there could be some messages already printed with erofs_xxx before
>>>> mkfs_parse_options_cfg(), I think we can use default level (0) before
>>>> checking its vaildity and switch to the given level after it, as below:
>>>>
>>>>                   case 'd':
>>>> -                       cfg.c_dbg_lvl = parse_num_from_str(optarg);
>>>> +                       i = atoi(optarg);
>>>> +                       if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
>>>> +                               erofs_err("invalid debug level %d", i);
>>>> +                               return -EINVAL;
>>>> +                       }
>>>> +                       cfg.c_dbg_lvl = i;
>>>>
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=dev&id=26097242976cce68e21d8b569dfda63fb68f356c
>>>>
>>>> Do you agree? :)
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>>
>>>>> --Pratik.
>>>>>
>>>>>
>>>>> On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang <hsiangkao@aol.com> wrote:
>>>>>
>>>>>> On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde wrote:
>>>>>>> handling the case of incorrect debug level.
>>>>>>> Added an enumerated type for supported debug levels.
>>>>>>> Using 'atoi' in place of 'parse_num_from_str'.
>>>>>>>
>>>>>>> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
>>>>>>> ---
>>>>>>>    include/erofs/print.h | 18 +++++++++++++-----
>>>>>>>    mkfs/main.c           | 19 ++++++++-----------
>>>>>>>    2 files changed, 21 insertions(+), 16 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/erofs/print.h b/include/erofs/print.h
>>>>>>> index bc0b8d4..296cbbf 100644
>>>>>>> --- a/include/erofs/print.h
>>>>>>> +++ b/include/erofs/print.h
>>>>>>> @@ -12,6 +12,15 @@
>>>>>>>    #include "config.h"
>>>>>>>    #include <stdio.h>
>>>>>>>
>>>>>>> +enum {
>>>>>>> +     EROFS_MSG_MIN = 0,
>>>>>>> +     EROFS_ERR     = 0,
>>>>>>> +     EROFS_WARN    = 2,
>>>>>>> +     EROFS_INFO    = 3,
>>>>>>> +     EROFS_DBG     = 7,
>>>>>>> +     EROFS_MSG_MAX = 9
>>>>>>> +};
>>>>>>> +
>>>>>>>    #define FUNC_LINE_FMT "%s() Line[%d] "
>>>>>>>
>>>>>>>    #ifndef pr_fmt
>>>>>>> @@ -19,7 +28,7 @@
>>>>>>>    #endif
>>>>>>>
>>>>>>>    #define erofs_dbg(fmt, ...) do {                             \
>>>>>>> -     if (cfg.c_dbg_lvl >= 7) {                               \
>>>>>>> +     if (cfg.c_dbg_lvl >= EROFS_DBG) {                       \
>>>>>>>                 fprintf(stdout,                                 \
>>>>>>>                         pr_fmt(fmt),                            \
>>>>>>>                         __func__,                               \
>>>>>>> @@ -29,7 +38,7 @@
>>>>>>>    } while (0)
>>>>>>>
>>>>>>>    #define erofs_info(fmt, ...) do {                            \
>>>>>>> -     if (cfg.c_dbg_lvl >= 3) {                               \
>>>>>>> +     if (cfg.c_dbg_lvl >= EROFS_INFO) {                      \
>>>>>>>                 fprintf(stdout,                                 \
>>>>>>>                         pr_fmt(fmt),                            \
>>>>>>>                         __func__,                               \
>>>>>>> @@ -40,7 +49,7 @@
>>>>>>>    } while (0)
>>>>>>>
>>>>>>>    #define erofs_warn(fmt, ...) do {                            \
>>>>>>> -     if (cfg.c_dbg_lvl >= 2) {                               \
>>>>>>> +     if (cfg.c_dbg_lvl >= EROFS_WARN) {                      \
>>>>>>>                 fprintf(stdout,                                 \
>>>>>>>                         pr_fmt(fmt),                            \
>>>>>>>                         __func__,                               \
>>>>>>> @@ -51,7 +60,7 @@
>>>>>>>    } while (0)
>>>>>>>
>>>>>>>    #define erofs_err(fmt, ...) do {                             \
>>>>>>> -     if (cfg.c_dbg_lvl >= 0) {                               \
>>>>>>> +     if (cfg.c_dbg_lvl >= EROFS_ERR) {                       \
>>>>>>>                 fprintf(stderr,                                 \
>>>>>>>                         "Err: " pr_fmt(fmt),                    \
>>>>>>>                         __func__,                               \
>>>>>>> @@ -64,4 +73,3 @@
>>>>>>>
>>>>>>>
>>>>>>>    #endif
>>>>>>> -
>>>>>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>>>>>> index fdb65fd..d915d00 100644
>>>>>>> --- a/mkfs/main.c
>>>>>>> +++ b/mkfs/main.c
>>>>>>> @@ -30,16 +30,6 @@ static void usage(void)
>>>>>>>         fprintf(stderr, " -EX[,...] X=extended options\n");
>>>>>>>    }
>>>>>>>
>>>>>>> -u64 parse_num_from_str(const char *str)
>>>>>>> -{
>>>>>>> -     u64 num      = 0;
>>>>>>> -     char *endptr = NULL;
>>>>>>> -
>>>>>>> -     num = strtoull(str, &endptr, 10);
>>>>>>> -     BUG_ON(num == ULLONG_MAX);
>>>>>>> -     return num;
>>>>>>> -}
>>>>>>> -
>>>>>>>    static int parse_extended_opts(const char *opts)
>>>>>>>    {
>>>>>>>    #define MATCH_EXTENTED_OPT(opt, token, keylen) \
>>>>>>> @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int argc, char
>>>>>> *argv[])
>>>>>>>                         break;
>>>>>>>
>>>>>>>                 case 'd':
>>>>>>> -                     cfg.c_dbg_lvl = parse_num_from_str(optarg);
>>>>>>> +                     cfg.c_dbg_lvl = atoi(optarg);
>>>>>>> +                     if (cfg.c_dbg_lvl < EROFS_MSG_MIN
>>>>>>> +                         || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
>>>>>>> +                             fprintf(stderr,
>>>>>>> +                                     "invalid debug level %d\n",
>>>>>>> +                                     cfg.c_dbg_lvl);
>>>>>>
>>>>>> How about using erofs_err as my previous patch attached?
>>>>>> I wonder if there are some specfic reasons to directly use fprintf
>>>> instead?
>>>>>>
>>>>>> I will apply it with this minor fixup (no need to resend again), if you
>>>>>> have
>>>>>> other considerations, reply me in this thread, thanks. :)
>>>>>>
>>>>>> Thanks,
>>>>>> Gao Xiang
>>>>>>
>>>>>>> +                             return -EINVAL;
>>>>>>> +                     }
>>>>>>>                         break;
>>>>>>>
>>>>>>>                 case 'E':
>>>>>>> --
>>>>>>> 2.9.3
>>>>>>>
>>>>>>
>>>>
>>>
