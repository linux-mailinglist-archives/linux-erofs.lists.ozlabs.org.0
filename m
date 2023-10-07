Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E65277BC60A
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Oct 2023 10:25:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S2ddd4BGPz3cRn
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Oct 2023 19:25:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S2ddV2bDKz3c2b
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Oct 2023 19:25:00 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VtZjECI_1696667090;
Received: from 30.97.48.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VtZjECI_1696667090)
          by smtp.aliyun-inc.com;
          Sat, 07 Oct 2023 16:24:53 +0800
Message-ID: <9ef1b3c3-9d3c-5639-1859-6d419b2a9594@linux.alibaba.com>
Date: Sat, 7 Oct 2023 16:24:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1] erofs-utils: Fix cross compile with autoconf
To: Sandeep Dhavale <dhavale@google.com>
References: <20231005224008.817830-1-dhavale@google.com>
 <531b8a1b-efbb-8fcb-a0f8-018c8650611f@linux.alibaba.com>
 <CAB=BE-RR4MsevBPbrmr-QmH8ihzTnQhrQuJoh1Fr6BquP9AS8A@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-RR4MsevBPbrmr-QmH8ihzTnQhrQuJoh1Fr6BquP9AS8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/10/7 15:16, Sandeep Dhavale wrote:
> On Fri, Oct 6, 2023 at 8:27 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Sandeep!
>>
>> On 2023/10/6 06:40, Sandeep Dhavale wrote:
>>> AC_RUN_IFELSE expects the action if cross compiling. If not provided
>>> cross compilation fails with error "configure: error: cannot run test
>>> program while cross compiling".
>>> Use 4096 as the buest guess PAGESIZE if cross compiling as it is still
>>> the most common page size.
>>
>> Thanks for your report!
>>
>>>
>>> Reported-in: https://lore.kernel.org/all/0101018aec71b531-0a354b1a-0b70-47a1-8efc-fea8c439304c-000000@us-west-2.amazonses.com/
>>> Fixes: 8ee2e591dfd6 ("erofs-utils: support detecting maximum block size")
>>> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
>>> ---
>>>    configure.ac | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 13ee616..a546310 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -284,8 +284,8 @@ AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
>>>        return 0;
>>>    ]])],
>>>                                 [erofs_cv_max_block_size=`cat conftest.out`],
>>> -                             [],
>>> -                             []))
>>> +                             [erofs_cv_max_block_size=4096],
>>> +                             [erofs_cv_max_block_size=4096]))
>>>    ], [erofs_cv_max_block_size=$MAX_BLOCK_SIZE])
>>
>> Actually the following check will reset erofs_cv_max_block_size to 4096
>> if needed. But it seems that it has syntax errors.
>>
> Hi Gao,
> If I understand this correctly, the problem here is not having defined
> action if we are cross compiling for AC_RUN_IFELSE(). The cross
> compilation will fail until we have an action defined.
> 
> While at it I specified erofs_cv_max_block_size=4096 for the second
> action which will be the value if the test program fails to detect the
> page size.

Oh, thanks! got it.  How about updating erofs_cv_max_block_size to
$MAX_BLOCK_SIZE first, and fallback to 4096 if MAX_BLOCK_SIZE is
not defined? (We need to use $MAX_BLOCK_SIZE if defined anyway...)

I mean applying the following diff in addition to the previous diff too?

+                             [erofs_cv_max_block_size=$MAX_BLOCK_SIZE],
+                             [erofs_cv_max_block_size=$MAX_BLOCK_SIZE]))
     ], [erofs_cv_max_block_size=$MAX_BLOCK_SIZE])

If it works, I could apply this version.

Thanks,
Gao Xiang

> 
> With your suggested patch, cross compilation still fails with the error
>> configure: error: cannot run test program while cross compiling
>> See `config.log' for more details
> 
> Thanks,
> Sandeep.
> 
>> I wonder if the following diff could fix the issue too?
>>
>> Thanks,
>> Gao Xiang
>>
>> diff --git a/configure.ac b/configure.ac
>> index 13ee616..94eec01 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -288,6 +288,9 @@ AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
>>                                 []))
>>    ], [erofs_cv_max_block_size=$MAX_BLOCK_SIZE])
>>
>> +AS_IF([test "x$erofs_cv_max_block_size" = "x"],
>> +      [erofs_cv_max_block_size=4096], [])
>> +
>>    # Configure debug mode
>>    AS_IF([test "x$enable_debug" != "xno"], [], [
>>      dnl Turn off all assert checking.
>> @@ -501,9 +504,6 @@ if test "x$have_libdeflate" = "xyes"; then
>>    fi
>>
>>    # Dump maximum block size
>> -AS_IF([test "x$erofs_cv_max_block_size" = "x"],
>> -      [$erofs_cv_max_block_size = 4096], [])
>> -
>>    AC_DEFINE_UNQUOTED([EROFS_MAX_BLOCK_SIZE], [$erofs_cv_max_block_size],
>>                     [The maximum block size which erofs-utils supports])
