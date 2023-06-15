Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B36731808
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 14:01:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhgrL6zm2z3bSt
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 22:01:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhgrH1qy2z30Ns
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 22:01:46 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qhgbv55JMz9v7Vl
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 19:51:07 +0800 (CST)
Received: from [10.174.177.238] (unknown [10.174.177.238])
	by APP2 (Coremail) with SMTP id BqC_BwDnGYSd_YpkAJ3UCA--.7891S2;
	Thu, 15 Jun 2023 12:01:37 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------0gjmOE0a0d0Jek0W89oflp00"
Message-ID: <b52aefc8-34bf-6d36-3a41-d8ded30d065b@huaweicloud.com>
Date: Thu, 15 Jun 2023 20:01:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/4] erofs-utils: lib: unify all identical compressor
 print function
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230615101727.946446-1-guoxuenan@huawei.com>
 <20230615101727.946446-3-guoxuenan@huawei.com>
 <bccba1a8-b934-ea2e-04db-42da6ee63e3a@linux.alibaba.com>
From: Guo Xuenan <guoxuenan@huaweicloud.com>
In-Reply-To: <bccba1a8-b934-ea2e-04db-42da6ee63e3a@linux.alibaba.com>
X-CM-TRANSID: BqC_BwDnGYSd_YpkAJ3UCA--.7891S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF45ZFy7KFyxXFW8Zr1xuFg_yoWrtF1Upr
	1rGr18GrW8Xr18Aw48Jr4jgFyfJr4xJw1UJw18Ja48J3W5JrZ2qF10qr1vgrWUGrWrXa1v
	yw42vw1Uury5tr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21lYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	Cjr7xvwVCIw2I0I7xG6c02F41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r106r1rMI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UGD73UUUUU=
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
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
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------0gjmOE0a0d0Jek0W89oflp00
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023/6/15 18:46, Gao Xiang wrote:
>
>
> On 2023/6/15 18:17, Guo Xuenan via Linux-erofs wrote:
>> {dump,fsck}.erofs use the same compressor print function,
>> available compressors means which algothrims are currently
>> supported by binary tools.
>> supported compressors including all algothrims that are ready
>> for your erofs binary tools.
>>
>> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
>> ---
>>   fsck/main.c              | 15 +-----------
>>   include/erofs/compress.h |  3 ++-
>>   lib/compressor.c         | 51 ++++++++++++++++++++++++++--------------
>>   mkfs/main.c              | 15 +-----------
>>   4 files changed, 38 insertions(+), 46 deletions(-)
>>
>> diff --git a/fsck/main.c b/fsck/main.c
>> index f816bec..e559050 100644
>> --- a/fsck/main.c
>> +++ b/fsck/main.c
>> @@ -49,19 +49,6 @@ static struct option long_options[] = {
>>       {0, 0, 0, 0},
>>   };
>>   -static void print_available_decompressors(FILE *f, const char *delim)
>> -{
>> -    unsigned int i = 0;
>> -    const char *s;
>> -
>> -    while ((s = z_erofs_list_available_compressors(i)) != NULL) {
>> -        if (i++)
>> -            fputs(delim, f);
>> -        fputs(s, f);
>> -    }
>> -    fputc('\n', f);
>> -}
>> -
>>   static void usage(void)
>>   {
>>       fputs("usage: [options] IMAGE\n\n"
>> @@ -84,7 +71,7 @@ static void usage(void)
>>             " --no-preserve-owner    extract as yourself\n"
>>             " --no-preserve-perms    apply user's umask when 
>> extracting permissions\n"
>>             "\nSupported algorithms are: ", stderr);
>> -    print_available_decompressors(stderr, ", ");
>> +    erofs_print_available_compressors(stderr);
>>   }
>>     static void erofsfsck_print_version(void)
>> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
>> index 08af9e3..f1b9bbd 100644
>> --- a/include/erofs/compress.h
>> +++ b/include/erofs/compress.h
>> @@ -22,7 +22,8 @@ int erofs_write_compressed_file(struct erofs_inode 
>> *inode, int fd);
>>   int z_erofs_compress_init(struct erofs_buffer_head *bh);
>>   int z_erofs_compress_exit(void);
>>   -const char *z_erofs_list_available_compressors(unsigned int i);
>> +void erofs_print_available_compressors(FILE *f);
>> +void erofs_print_supported_compressors(FILE *f, unsigned int mask);
>>     static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
>>   {
>> diff --git a/lib/compressor.c b/lib/compressor.c
>> index 88a2fb0..da8d1b9 100644
>> --- a/lib/compressor.c
>> +++ b/lib/compressor.c
>> @@ -10,18 +10,6 @@
>>     #define EROFS_CONFIG_COMPR_DEF_BOUNDARY        (128)
>>   -static const struct erofs_compressor *compressors[] = {
>> -#if LZ4_ENABLED
>> -#if LZ4HC_ENABLED
>> -        &erofs_compressor_lz4hc,
>> -#endif
>> -        &erofs_compressor_lz4,
>> -#endif
>> -#if HAVE_LIBLZMA
>> -        &erofs_compressor_lzma,
>> -#endif
>> -};
>> -
>>   /* for compressors type configuration */
>>   static struct erofs_supported_algothrim {
>>       int algtype;
>> @@ -119,9 +107,38 @@ int erofs_compress_destsize(const struct 
>> erofs_compress *c,
>>       return ret;
>>   }
>>   -const char *z_erofs_list_available_compressors(unsigned int i)
>> +void erofs_print_supported_compressors(FILE *f, unsigned int mask)
>>   {
>> -    return i >= ARRAY_SIZE(compressors) ? NULL : compressors[i]->name;
>> +    unsigned int i = 0;
>> +    int comma = false;
>> +    const char *s;
>> +
>> +    while (i < erofs_ccfg.erofs_ccfg_num) {
>> +        s = erofs_ccfg.compressors[i].name;
>> +        if (s && (mask & (1 << 
>> erofs_ccfg.compressors[i++].algorithmtype))) {
>> +            if (comma)
>> +                fputs(", ", f);
>> +            else
>> +                comma = true;
>> +            fputs(s, f);
>> +        }
>> +    }
>> +    fputc('\n', f);
>> +}
>> +
>> +void erofs_print_available_compressors(FILE *f)
>> +{
>
> Should just erofs_print_supported_compressors(f, ~0) and avoid this 
> helper?
>
As commit message of this patch explained, available compressors means 
which algothrims are
currentlyavailable to user in binary tools. I mean fsck/mkfs.erofs 
binary tools may only support
lz4 compression.erofs_print_available_compressors should only print lz4; 
but for dump.erofs ,
which is not used tomake erofs image, there is a bit difference here. 
dump.erofs should identify
all supportedalgorithms.
> Thanks,
> Gao Xiang
>
-- 
Best regards
Guo Xuenan

--------------0gjmOE0a0d0Jek0W89oflp00
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023/6/15 18:46, Gao Xiang wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:bccba1a8-b934-ea2e-04db-42da6ee63e3a@linux.alibaba.com">
      <br>
      <br>
      On 2023/6/15 18:17, Guo Xuenan via Linux-erofs wrote:
      <br>
      <blockquote type="cite">{dump,fsck}.erofs use the same compressor
        print function,
        <br>
        available compressors means which algothrims are currently
        <br>
        supported by binary tools.
        <br>
        supported compressors including all algothrims that are ready
        <br>
        for your erofs binary tools.
        <br>
        <br>
        Signed-off-by: Guo Xuenan <a class="moz-txt-link-rfc2396E" href="mailto:guoxuenan@huawei.com">&lt;guoxuenan@huawei.com&gt;</a>
        <br>
        ---
        <br>
          fsck/main.c              | 15 +-----------
        <br>
          include/erofs/compress.h |  3 ++-
        <br>
          lib/compressor.c         | 51
        ++++++++++++++++++++++++++--------------
        <br>
          mkfs/main.c              | 15 +-----------
        <br>
          4 files changed, 38 insertions(+), 46 deletions(-)
        <br>
        <br>
        diff --git a/fsck/main.c b/fsck/main.c
        <br>
        index f816bec..e559050 100644
        <br>
        --- a/fsck/main.c
        <br>
        +++ b/fsck/main.c
        <br>
        @@ -49,19 +49,6 @@ static struct option long_options[] = {
        <br>
              {0, 0, 0, 0},
        <br>
          };
        <br>
          -static void print_available_decompressors(FILE *f, const char
        *delim)
        <br>
        -{
        <br>
        -    unsigned int i = 0;
        <br>
        -    const char *s;
        <br>
        -
        <br>
        -    while ((s = z_erofs_list_available_compressors(i)) != NULL)
        {
        <br>
        -        if (i++)
        <br>
        -            fputs(delim, f);
        <br>
        -        fputs(s, f);
        <br>
        -    }
        <br>
        -    fputc('\n', f);
        <br>
        -}
        <br>
        -
        <br>
          static void usage(void)
        <br>
          {
        <br>
              fputs("usage: [options] IMAGE\n\n"
        <br>
        @@ -84,7 +71,7 @@ static void usage(void)
        <br>
                    " --no-preserve-owner    extract as yourself\n"
        <br>
                    " --no-preserve-perms    apply user's umask when
        extracting permissions\n"
        <br>
                    "\nSupported algorithms are: ", stderr);
        <br>
        -    print_available_decompressors(stderr, ", ");
        <br>
        +    erofs_print_available_compressors(stderr);
        <br>
          }
        <br>
            static void erofsfsck_print_version(void)
        <br>
        diff --git a/include/erofs/compress.h b/include/erofs/compress.h
        <br>
        index 08af9e3..f1b9bbd 100644
        <br>
        --- a/include/erofs/compress.h
        <br>
        +++ b/include/erofs/compress.h
        <br>
        @@ -22,7 +22,8 @@ int erofs_write_compressed_file(struct
        erofs_inode *inode, int fd);
        <br>
          int z_erofs_compress_init(struct erofs_buffer_head *bh);
        <br>
          int z_erofs_compress_exit(void);
        <br>
          -const char *z_erofs_list_available_compressors(unsigned int
        i);
        <br>
        +void erofs_print_available_compressors(FILE *f);
        <br>
        +void erofs_print_supported_compressors(FILE *f, unsigned int
        mask);
        <br>
            static inline bool erofs_is_packed_inode(struct erofs_inode
        *inode)
        <br>
          {
        <br>
        diff --git a/lib/compressor.c b/lib/compressor.c
        <br>
        index 88a2fb0..da8d1b9 100644
        <br>
        --- a/lib/compressor.c
        <br>
        +++ b/lib/compressor.c
        <br>
        @@ -10,18 +10,6 @@
        <br>
            #define EROFS_CONFIG_COMPR_DEF_BOUNDARY        (128)
        <br>
          -static const struct erofs_compressor *compressors[] = {
        <br>
        -#if LZ4_ENABLED
        <br>
        -#if LZ4HC_ENABLED
        <br>
        -        &amp;erofs_compressor_lz4hc,
        <br>
        -#endif
        <br>
        -        &amp;erofs_compressor_lz4,
        <br>
        -#endif
        <br>
        -#if HAVE_LIBLZMA
        <br>
        -        &amp;erofs_compressor_lzma,
        <br>
        -#endif
        <br>
        -};
        <br>
        -
        <br>
          /* for compressors type configuration */
        <br>
          static struct erofs_supported_algothrim {
        <br>
              int algtype;
        <br>
        @@ -119,9 +107,38 @@ int erofs_compress_destsize(const struct
        erofs_compress *c,
        <br>
              return ret;
        <br>
          }
        <br>
          -const char *z_erofs_list_available_compressors(unsigned int
        i)
        <br>
        +void erofs_print_supported_compressors(FILE *f, unsigned int
        mask)
        <br>
          {
        <br>
        -    return i &gt;= ARRAY_SIZE(compressors) ? NULL :
        compressors[i]-&gt;name;
        <br>
        +    unsigned int i = 0;
        <br>
        +    int comma = false;
        <br>
        +    const char *s;
        <br>
        +
        <br>
        +    while (i &lt; erofs_ccfg.erofs_ccfg_num) {
        <br>
        +        s = erofs_ccfg.compressors[i].name;
        <br>
        +        if (s &amp;&amp; (mask &amp; (1 &lt;&lt;
        erofs_ccfg.compressors[i++].algorithmtype))) {
        <br>
        +            if (comma)
        <br>
        +                fputs(", ", f);
        <br>
        +            else
        <br>
        +                comma = true;
        <br>
        +            fputs(s, f);
        <br>
        +        }
        <br>
        +    }
        <br>
        +    fputc('\n', f);
        <br>
        +}
        <br>
        +
        <br>
        +void erofs_print_available_compressors(FILE *f)
        <br>
        +{
        <br>
      </blockquote>
      <br>
      Should just erofs_print_supported_compressors(f, ~0) and avoid
      this helper?
      <br>
      <br>
    </blockquote>
    <font face="monospace">As commit message of this patch explained,
      available compressors means which algothrims are </font><br>
    <font face="monospace">currently</font><font face="monospace">
      available to user in binary tools. I mean fsck/mkfs.erofs binary
      tools may only support </font><br>
    <font face="monospace">lz4 compression.</font><font face="monospace">erofs_print_available_compressors
      should only print lz4; but for dump.erofs ,</font><br>
    <font face="monospace">which is not used to</font><font
      face="monospace"> make erofs image, there is a bit difference
      here. dump.erofs should identify</font><br>
    <font face="monospace">all supported</font><font face="monospace">
      algorithms</font><span style="color: rgb(51, 51, 51); font-family:
      &quot;Helvetica Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans
      GB&quot;, &quot;Hiragino Sans GB W3&quot;, &quot;Microsoft YaHei
      UI&quot;, &quot;Microsoft YaHei&quot;, sans-serif; font-size:
      13px; font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; white-space: normal;
      text-decoration-thickness: initial; text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"><font face="monospace">.</font></span><br>
    <span style="color: rgb(51, 51, 51); font-family: &quot;Helvetica
      Neue&quot;, Helvetica, Arial, &quot;Hiragino Sans GB&quot;,
      &quot;Hiragino Sans GB W3&quot;, &quot;Microsoft YaHei UI&quot;,
      &quot;Microsoft YaHei&quot;, sans-serif; font-size: 13px;
      font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; white-space: normal;
      text-decoration-thickness: initial; text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"></span>
    <blockquote type="cite"
      cite="mid:bccba1a8-b934-ea2e-04db-42da6ee63e3a@linux.alibaba.com">Thanks,
      <br>
      Gao Xiang
      <br>
      <br>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Best regards
Guo Xuenan</pre>
  </body>
</html>

--------------0gjmOE0a0d0Jek0W89oflp00--

