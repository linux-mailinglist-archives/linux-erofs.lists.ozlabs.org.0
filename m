Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6309805761
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Dec 2023 15:35:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sl3381BRFz3cY0
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 01:35:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sl3300Gnhz3cTF
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 01:34:48 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VxuuXco_1701786878;
Received: from 30.27.65.35(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxuuXco_1701786878)
          by smtp.aliyun-inc.com;
          Tue, 05 Dec 2023 22:34:40 +0800
Message-ID: <8597c64c-d26a-8073-9d00-b629bbb0ee33@linux.alibaba.com>
Date: Tue, 5 Dec 2023 22:34:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Weird EROFS data corruption
To: Juhyung Park <qkrwngud825@gmail.com>
References: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
 <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com>
 <CAD14+f2G-buxTaWgb23DYW-HSd1sch6tJNKV2strt=toASZXQQ@mail.gmail.com>
 <649a3bc4-58bb-1dc8-85fb-a56e47b3d5c9@linux.alibaba.com>
 <CAD14+f1u6gnHLhGSoQxL9wLq9vDYse+Ac8zxep-O2E8hHreT2w@mail.gmail.com>
 <275f025d-e2f1-eaff-6af1-e909d370cee0@linux.alibaba.com>
 <CAD14+f3zgwgUugjnB7UGCYh4j3iXYsvv_DJ3yvwduA1xf3xn=A@mail.gmail.com>
 <d7c7ea8c-6e2f-e8d8-88c3-4952c506ed13@linux.alibaba.com>
 <CAD14+f2hPLv6RPZdYyi8q8SQGiBox2fYUaWwuBEjEbZKQdyU7g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAD14+f2hPLv6RPZdYyi8q8SQGiBox2fYUaWwuBEjEbZKQdyU7g@mail.gmail.com>
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
Cc: Yann Collet <yann.collet.73@gmail.com>, linux-erofs@lists.ozlabs.org, linux-crypto@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/12/5 22:23, Juhyung Park wrote:
> Hi Gao,
> 
> On Tue, Dec 5, 2023 at 4:32 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Juhyung,
>>
>> On 2023/12/4 11:41, Juhyung Park wrote:
>>
>> ...
>>>
>>>>
>>>> - Could you share the full message about the output of `lscpu`?
>>>
>>> Sure:
>>>
>>> Architecture:            x86_64
>>>     CPU op-mode(s):        32-bit, 64-bit
>>>     Address sizes:         39 bits physical, 48 bits virtual
>>>     Byte Order:            Little Endian
>>> CPU(s):                  8
>>>     On-line CPU(s) list:   0-7
>>> Vendor ID:               GenuineIntel
>>>     BIOS Vendor ID:        Intel(R) Corporation
>>>     Model name:            11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GHz
>>>       BIOS Model name:     11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GHz None CPU
>>>                             @ 3.0GHz
>>>       BIOS CPU family:     198
>>>       CPU family:          6
>>>       Model:               140
>>>       Thread(s) per core:  2
>>>       Core(s) per socket:  4
>>>       Socket(s):           1
>>>       Stepping:            1
>>>       CPU(s) scaling MHz:  60%
>>>       CPU max MHz:         4800.0000
>>>       CPU min MHz:         400.0000
>>>       BogoMIPS:            5990.40
>>>       Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc
>>>                            a cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
>>>                            ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art
>>>                             arch_perfmon pebs bts rep_good nopl xtopology nonstop_
>>>                            tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes6
>>>                            4 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xt
>>>                            pr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_dead
>>>                            line_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowp
>>>                            refetch cpuid_fault epb cat_l2 cdp_l2 ssbd ibrs ibpb st
>>>                            ibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_
>>>                            ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
>>>                             rdt_a avx512f avx512dq rdseed adx smap avx512ifma clfl
>>>                            ushopt clwb intel_pt avx512cd sha_ni avx512bw avx512vl
>>>                            xsaveopt xsavec xgetbv1 xsaves split_lock_detect dtherm
>>>                             ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
>>>                             hwp_pkg_req vnmi avx512vbmi umip pku ospke avx512_vbmi
>>>                            2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg tme av
>>>                            x512_vpopcntdq rdpid movdiri movdir64b fsrm avx512_vp2i
>>
>> Sigh, I've been thinking.  Here FSRM is the most significant difference between
>> our environments, could you only try the following diff to see if there's any
>> difference anymore? (without the previous disable patch.)
>>
>> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
>> index 1b60ae81ecd8..1b52a913233c 100644
>> --- a/arch/x86/lib/memmove_64.S
>> +++ b/arch/x86/lib/memmove_64.S
>> @@ -41,9 +41,7 @@ SYM_FUNC_START(__memmove)
>>    #define CHECK_LEN     cmp $0x20, %rdx; jb 1f
>>    #define MEMMOVE_BYTES movq %rdx, %rcx; rep movsb; RET
>>    .Lmemmove_begin_forward:
>> -       ALTERNATIVE_2 __stringify(CHECK_LEN), \
>> -                     __stringify(CHECK_LEN; MEMMOVE_BYTES), X86_FEATURE_ERMS, \
>> -                     __stringify(MEMMOVE_BYTES), X86_FEATURE_FSRM
>> +       CHECK_LEN
>>
>>          /*
>>           * movsq instruction have many startup latency
> 
> Yup, that also seems to fix it.
> Are we looking at a potential memmove issue?

I'm still analyzing this behavior as well as the root cause and
I will also try to get a recent cloud server with FSRM myself
to find more clues.

Thanks,
Gao Xiang
