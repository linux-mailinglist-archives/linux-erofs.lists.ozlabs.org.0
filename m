Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D09488D4
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 07:09:06 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ISnOfSKR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WdLv25jWCz3cb1
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 15:09:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ISnOfSKR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WdLtw38g4z3cND
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Aug 2024 15:08:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722920930; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=7qzV1C9+fUr/GxKNQqJ+GFcSjWPnwbgyhXZaifNLDd4=;
	b=ISnOfSKR+A/l91fCS0jZd9tTvOcXjbNbqjb8mzY4YLLfd/QcMIWzCs3t4d9vRlv0vxVprFwsdqKmgCcGN6YpHJ1+xd3KXM/vc7HoNuKqPNr68vYEPfyvGJPUHlKoTcvmpCdUpyrLpM32sPRfecvWrD0c0HxSYu8lGNdIq6jJM2Y=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WCE8S6J_1722920928;
Received: from 30.221.132.245(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WCE8S6J_1722920928)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 13:08:49 +0800
Content-Type: multipart/alternative;
 boundary="------------LCZV4Y5mskrBGtPO2RIofz5b"
Message-ID: <f829e10f-ffd2-4907-899d-cd2ca40718a8@linux.alibaba.com>
Date: Tue, 6 Aug 2024 13:08:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix potential overflow issue
To: Sandeep Dhavale <dhavale@google.com>
References: <20240805032510.2637488-1-hongzhen@linux.alibaba.com>
 <CAB=BE-Q=wWXuai+pMgQMEBe0oODRNM7MVkzu5bZ2K60JmXZv2w@mail.gmail.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <CAB=BE-Q=wWXuai+pMgQMEBe0oODRNM7MVkzu5bZ2K60JmXZv2w@mail.gmail.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------LCZV4Y5mskrBGtPO2RIofz5b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/8/6 02:39, Sandeep Dhavale wrote:
> On Sun, Aug 4, 2024 at 8:25 PM Hongzhen Luo<hongzhen@linux.alibaba.com>  wrote:
>> Coverity-id: 502377
>>
>> Signed-off-by: Hongzhen Luo<hongzhen@linux.alibaba.com>
>> ---
>>   lib/kite_deflate.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
>> index a5ebd66..e52e382 100644
>> --- a/lib/kite_deflate.c
>> +++ b/lib/kite_deflate.c
>> @@ -817,7 +817,8 @@ static const struct kite_matchfinder_cfg {
>>   /* 9 */ {32, 258, 258, 4096, true},    /* maximum compression */
>>   };
>>
>> -static int kite_mf_init(struct kite_matchfinder *mf, int wsiz, int level)
>> +static int kite_mf_init(struct kite_matchfinder *mf, unsigned int wsiz,
>> +                       int level)
>>   {
>>          const struct kite_matchfinder_cfg *cfg;
>>
>> --
>> 2.43.5
>>
> Hi Hongzhen,
> Can you please explain to me where the potential overflow is? Checkers
> can be smart so easy for me to miss.
> I see a below check in kitle_me_init()
>
>      if (wsiz > kHistorySize32 || (1 << ilog2(wsiz)) != wsiz)
>            return -EINVAL;
>
> So any larger value than kHistorySize32 which is (1U << 15) is already
> rejected. So what overflow case is this int => unsigned int type
> conversion solving?
>
> Thanks,
> Sandeep.

Hi Sandeep,

The coverity tool says that for code `mf->chain = 
malloc(sizeof(mf->chain[0]) * wsiz);` there is a potential overflow issue:

overflow_const: Expression 4UL * wsiz, which is equal to 
18446744065119617024, where wsiz is known to be equal to -2147483648, 
overflows the type that receives it, an unsigned integer 64 bits wide.

For example, when `wsiz` is set to -1, it is converted to an unsigned 
long value of 18446744073709551615, and multiplying this by 4 would lead 
to an overflow error. Consequently, I have defined wsiz as unsigned int, 
which has a maximum value of 4294967295. After converting this to 
unsigned long and multiplying by 4, an overflow will not occur.

In practical applications, however, `wsiz` would not take on such odd 
values.

---

Thanks,

Hongzhen Luo

--------------LCZV4Y5mskrBGtPO2RIofz5b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024/8/6 02:39, Sandeep Dhavale
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAB=BE-Q=wWXuai+pMgQMEBe0oODRNM7MVkzu5bZ2K60JmXZv2w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Sun, Aug 4, 2024 at 8:25 PM Hongzhen Luo <a class="moz-txt-link-rfc2396E" href="mailto:hongzhen@linux.alibaba.com">&lt;hongzhen@linux.alibaba.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Coverity-id: 502377

Signed-off-by: Hongzhen Luo <a class="moz-txt-link-rfc2396E" href="mailto:hongzhen@linux.alibaba.com">&lt;hongzhen@linux.alibaba.com&gt;</a>
---
 lib/kite_deflate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index a5ebd66..e52e382 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -817,7 +817,8 @@ static const struct kite_matchfinder_cfg {
 /* 9 */ {32, 258, 258, 4096, true},    /* maximum compression */
 };

-static int kite_mf_init(struct kite_matchfinder *mf, int wsiz, int level)
+static int kite_mf_init(struct kite_matchfinder *mf, unsigned int wsiz,
+                       int level)
 {
        const struct kite_matchfinder_cfg *cfg;

--
2.43.5

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Hi Hongzhen,
Can you please explain to me where the potential overflow is? Checkers
can be smart so easy for me to miss.
I see a below check in kitle_me_init()

    if (wsiz &gt; kHistorySize32 || (1 &lt;&lt; ilog2(wsiz)) != wsiz)
          return -EINVAL;

So any larger value than kHistorySize32 which is (1U &lt;&lt; 15) is already
rejected. So what overflow case is this int =&gt; unsigned int type
conversion solving?

Thanks,
Sandeep.
</pre>
    </blockquote>
    <p>Hi <span style="white-space: pre-wrap">Sandeep</span>,</p>
    <p>The coverity tool says that for code `<span
        id="xref-L-4513213-1993-2" class="xref xref-L-4513213-268"
style="cursor: pointer; border-width: 1px; border-style: solid; border-color: transparent transparent rgb(204, 204, 204); color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">mf</span><span
style="color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">-&gt;</span><span
        id="xref-L-4513213-1299-3" class="xref xref-L-4513213-223"
style="cursor: pointer; border-width: 1px; border-style: solid; border-color: transparent transparent rgb(204, 204, 204); color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">chain</span><span
style="color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"> = </span><span
        id="xref-705860012-2-4" class="xref xref-173298888"
style="cursor: pointer; border-width: 1px; border-style: solid; border-color: transparent transparent rgb(204, 204, 204); color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">malloc</span><span
style="color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">(</span><span
        class="keyword"
style="font-weight: 700; color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">sizeof</span><span
style="color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">(</span><span
        id="xref-L-4513213-635-2" class="xref xref-L-4513213-268"
style="cursor: pointer; border-width: 1px; border-style: solid; border-color: transparent transparent rgb(204, 204, 204); color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">mf</span><span
style="color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">-&gt;</span><span
        id="xref-L-4513213-69-2" class="xref xref-L-4513213-223"
style="cursor: pointer; border-width: 1px; border-style: solid; border-color: transparent transparent rgb(204, 204, 204); color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">chain</span><span
style="color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">[</span><span
        class="literal"
style="color: rgb(63, 78, 222); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">0</span><span
style="color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">]) * </span><span
        id="xref-L-4513213-1237-2" class="xref xref-L-4513213-269"
style="cursor: pointer; border-width: 1px; border-style: solid; border-color: transparent transparent rgb(204, 204, 204); color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">wsiz</span><span
style="color: rgb(0, 0, 0); font-family: Consolas, &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;DejaVu Sans Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, Monaco, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: nowrap; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">);</span>`
      there is a potential overflow issue:</p>
    <p>overflow_const: Expression 4UL * wsiz, which is equal to
      18446744065119617024, where wsiz is known to be equal to
      -2147483648, overflows the type that receives it, an unsigned
      integer 64 bits wide.</p>
    <p>For example, when `wsiz` is set to -1, it is converted to an
      unsigned long value of 18446744073709551615, and multiplying this
      by 4 would lead to an overflow error. Consequently, I have defined
      wsiz as unsigned int, which has a maximum value of 4294967295.
      After converting this to unsigned long and multiplying by 4, an
      overflow will not occur.</p>
    <p>In practical applications, however, `wsiz` would not take on such
      odd values.</p>
    <p>---<br>
    </p>
    <p>Thanks,</p>
    <p>Hongzhen Luo<br>
    </p>
  </body>
</html>

--------------LCZV4Y5mskrBGtPO2RIofz5b--
