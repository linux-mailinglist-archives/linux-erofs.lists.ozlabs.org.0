Return-Path: <linux-erofs+bounces-1146-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5297ABAC442
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 11:25:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbXj36SsCz3cZt;
	Tue, 30 Sep 2025 19:25:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759224327;
	cv=none; b=M/GyuqSYRhv3ePeLvNfNHwLgco7SC35l1Suj68Kj/fx5LrrtKNoS11jVujKkWIrzrRFJQOADuTU/Otk/duIS3Ggv6ryG+7W8DW7VXWmBxuh5i85DA1CSq+0xA+IWuqOI/R29GPKQqahdwe7sB7uds0AWXNFTBM8GmB6EiXTl/IO7WUqvZ1pnYMEc33kIaQkQbYv0cRF5F4I/KTTK+KT0uh+OZrEoCuIStQVXi1vcnoVhDHc4q4SuCOekOtPmBX+0fGgdNpr4+sTpTXQLrM/KQ/Caj0ub9EdoYcP4NQFobkzYpaq+aiOTeHSyQPCyjCw5ahzE+/EZfFsePQwDEdjA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759224327; c=relaxed/relaxed;
	bh=bc3gZdcerIIQWmX/jk/9Q+mRlJTIUaMkZvtU1AjxYY0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=dOHeVGh2HKs5PayJpUSoOXCeqknNSfhdcJlLmIlD2TDWVCzx0DQFp6OQ6a1+AxfBwGScFNYqzakdVi+WN16Y7kYlemHcZm7vxAiL6mk4X9oHXjlD53EgaolqsYpd5/MvVp0sWJxkO7GZlJUwM2ys9XtGFsP2l+/I+lA7Yg8m1tTEqOzsUcST1SjPH9OllR+3q9HpeX4pRafrfXILEhItxnevfb4ymyaQ5g8ph3y+0K27qsJkIflWQQ6oq1cK5dRoxuencf7T2vhpvmEjqRAQKdbPxGQyFzpwJBkX0z6mSYVCWHMDwzPkDm4OH6i7bR6VpdN5BFfiD1+TF5XS7zVZag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Vub0P5Be; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Vub0P5Be;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2636 seconds by postgrey-1.37 at boromir; Tue, 30 Sep 2025 19:25:24 AEST
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbXj048L9z3cZ5
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 19:25:22 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bc3gZdcerIIQWmX/jk/9Q+mRlJTIUaMkZvtU1AjxYY0=;
	b=Vub0P5BeQ3wBjHIf3DRjuGpWBIiYZhGWMSNSlezbbVjpjzsp19iPM96wHwM9k9TdDRgatymrZ
	F2+kxz2N54L8kJbjb9QQM1wn/jKz1lyNtAUIY/+Y8NO8Buf7wOLIwGz6JQlYzKxYIWC6g2atB+f
	xaQoz+KOqCYUv9/3/jjNfko=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cbXhf40htz1prM0;
	Tue, 30 Sep 2025 17:25:06 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 045DF180464;
	Tue, 30 Sep 2025 17:25:18 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 17:25:17 +0800
Content-Type: multipart/alternative;
	boundary="------------58HyIMKOQbjGT17m49HbQ3EO"
Message-ID: <e3784812-ca18-4537-ae33-38813a5a6b4b@huawei.com>
Date: Tue, 30 Sep 2025 17:25:17 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: simplify s3erofs_prepare_url logic
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>
References: <20250930084056.170447-1-zhaoyifan28@huawei.com>
 <8c2c314c-3088-4e25-ab20-63ac6402b004@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <8c2c314c-3088-4e25-ab20-63ac6402b004@linux.alibaba.com>
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--------------58HyIMKOQbjGT17m49HbQ3EO
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/9/30 17:06, Gao Xiang wrote:
> Hi Yifan,
>
> On 2025/9/30 16:40, Yifan Zhao wrote:
>> From: zhaoyifan <zhaoyifan28@huawei.com>
>>
>> `mkfs.erofs` failed to generate image from Huawei OBS with the 
>> following command:
>>
>>     mkfs.erofs --s3=<endpoint>,urlstyle=vhost,sig=2 s3.erofs test-bucket
>>
>> because it mistakenly generated a url with repeated '/':
>>
>> https://test-bucket.<endpoint>//<keyname>
>>
>> In fact, the splitting of bucket name and path has already been 
>> performed prior
>> to the call to `s3erofs_prepare_url`, and this function does not need 
>> to handle
>> this logic. This patch simplifies this part accordingly and fixes the 
>> problem.
>>
>> Fixes: 29728ba8f6f6 ("erofs-utils: mkfs: support EROFS meta-only 
>> image generation from S3")
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>> ---
>>   lib/remotes/s3.c | 35 ++++++++++-------------------------
>>   1 file changed, 10 insertions(+), 25 deletions(-)
>>
>> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
>> index 2e7763e..2bd5322 100644
>> --- a/lib/remotes/s3.c
>> +++ b/lib/remotes/s3.c
>> @@ -41,17 +41,16 @@ struct s3erofs_curl_request {
>>     static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
>>                      const char *endpoint,
>> -                   const char *path, const char *key,
>
> I really think we should at least add a unittest for this.
>
Hi Xiang,


I agree that adding unit tests is necessary, but the issue is that it's 
difficult for us to verify the validity of the URL (and accompanying 
request headers) unless we actually make a request to a remote S3 
service. For example, the issue described in this patch only occurs with 
Huawei Cloud OBS, not with Alibaba Cloud OSS.

I suggest that as a first step, we could perform basic rule-based 
validation of the URL in unit tests—such as checking whether the 
canonical query matches the URI, etc. And I will do it before submitting 
any patches modifying the url perparation logic in s3erofs implementaion.

In the future, we could integrate tools that simulate an S3 service 
(e.g., https://github.com/adobe/S3Mock) as part of our CI testing 
pipeline (although this still isn't sufficient to cover the 
compatibility differences across various cloud providers' S3 
interfaces.... )

What's your opinion?


Thanks,

Yifan


> you could simply add
>
> #ifdef TEST
> int main(int argc, char argv[])
> {
>     testfunc1();        // and use assert() if test fails
>     testfunc2();
> }
> #endif
>
> and use gcc -o s3_test -Iinclude -lcurl lib/remote/s3.c to generate a 
> test program.
>
> Thanks,
> Gao Xiang
>
--------------58HyIMKOQbjGT17m49HbQ3EO
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2025/9/30 17:06, Gao Xiang wrote:<b=
r>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:8c2c314c-3088-4e25-ab20-63ac6402b004@linux.alibaba.com"=
>Hi
      Yifan,
      <br>
      <br>
      On 2025/9/30 16:40, Yifan Zhao wrote:
      <br>
      <blockquote type=3D"cite">From: zhaoyifan
        <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:zhaoyifan28@hua=
wei.com">&lt;zhaoyifan28@huawei.com&gt;</a>
        <br>
        <br>
        `mkfs.erofs` failed to generate image from Huawei OBS with the
        following command:
        <br>
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0mkfs.erofs --s3=3D&lt;endpoint&gt;,urlsty=
le=3Dvhost,sig=3D2
        s3.erofs test-bucket
        <br>
        <br>
        because it mistakenly generated a url with repeated '/':
        <br>
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0<a class=3D"moz-txt-link-freetext" href=3D=
"https://test-bucket">https://test-bucket</a>.&lt;endpoint&gt;//&lt;keyna=
me&gt;
        <br>
        <br>
        In fact, the splitting of bucket name and path has already been
        performed prior
        <br>
        to the call to `s3erofs_prepare_url`, and this function does not
        need to handle
        <br>
        this logic. This patch simplifies this part accordingly and
        fixes the problem.
        <br>
        <br>
        Fixes: 29728ba8f6f6 ("erofs-utils: mkfs: support EROFS meta-only
        image generation from S3")
        <br>
        Signed-off-by: Yifan Zhao <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:zhaoyifan28@huawei.com">&lt;zhaoyifan28@huawei.com&gt;</a>
        <br>
        ---
        <br>
        =C2=A0 lib/remotes/s3.c | 35 ++++++++++-------------------------
        <br>
        =C2=A0 1 file changed, 10 insertions(+), 25 deletions(-)
        <br>
        <br>
        diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
        <br>
        index 2e7763e..2bd5322 100644
        <br>
        --- a/lib/remotes/s3.c
        <br>
        +++ b/lib/remotes/s3.c
        <br>
        @@ -41,17 +41,16 @@ struct s3erofs_curl_request {
        <br>
        =C2=A0 =C2=A0 static int s3erofs_prepare_url(struct s3erofs_curl_=
request
        *req,
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *endpoi=
nt,
        <br>
        -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *path, const char *=
key,
        <br>
      </blockquote>
      <br>
      I really think we should at least add a unittest for this.=C2=A0<br=
>
      <br>
    </blockquote>
    <p>Hi Xiang,</p>
    <p><br>
    </p>
    <p
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-transla=
te-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y=
: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-p=
inch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-p=
osition: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --t=
w-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spa=
cing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-widt=
h: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(59 130 246 / .=
5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw=
-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-bri=
ghtness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-inv=
ert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-b=
lur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdro=
p-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-b=
ackdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-=
contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain=
-style: ; box-sizing: border-box; border-width: 0px; border-style: solid;=
 border-color: rgb(227, 227, 227); margin: 12px 0px; unicode-bidi: plaint=
ext; font-weight: 400; font-size: 16px; line-height: 1.75; letter-spacing=
: 0.32px; color: rgb(44, 44, 54); font-family: system-ui, ui-sans-serif, =
-apple-system, BlinkMacSystemFont, sans-serif, Inter, NotoSansHans; font-=
style: normal; font-variant-ligatures: normal; font-variant-caps: normal;=
 orphans: 2; text-align: start; text-indent: 0px; text-transform: none; w=
idows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space:=
 pre-line; background-color: rgb(255, 255, 255); text-decoration-thicknes=
s: initial; text-decoration-style: initial; text-decoration-color: initia=
l;">I agree that adding unit tests is necessary, but the issue is that it=
's difficult for us to verify the validity of the URL (and accompanying r=
equest headers) unless we actually make a request to a remote S3 service.=
 For example, the issue described in this patch only occurs with Huawei C=
loud OBS, not with Alibaba Cloud OSS.</p>
    <div class=3D"my-2"
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-transla=
te-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y=
: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-p=
inch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-p=
osition: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --t=
w-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spa=
cing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-widt=
h: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(59 130 246 / .=
5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw=
-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-bri=
ghtness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-inv=
ert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-b=
lur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdro=
p-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-b=
ackdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-=
contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain=
-style: ; box-sizing: border-box; border-width: 0px; border-style: solid;=
 border-color: rgb(227, 227, 227); margin-top: 0.5rem; margin-bottom: 0.5=
rem; color: rgb(44, 44, 54); font-family: system-ui, ui-sans-serif, -appl=
e-system, BlinkMacSystemFont, sans-serif, Inter, NotoSansHans; font-size:=
 16px; font-style: normal; font-variant-ligatures: normal; font-variant-c=
aps: normal; font-weight: 400; letter-spacing: 0.32px; orphans: 2; text-a=
lign: start; text-indent: 0px; text-transform: none; widows: 2; word-spac=
ing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; backgrou=
nd-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-de=
coration-style: initial; text-decoration-color: initial;"></div>
    <p data-spm-anchor-id=3D"a2ty_o01.29997173.0.i14.1ad3c921heqRwN"
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-transla=
te-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y=
: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-p=
inch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-p=
osition: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --t=
w-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spa=
cing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-widt=
h: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(59 130 246 / .=
5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw=
-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-bri=
ghtness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-inv=
ert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-b=
lur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdro=
p-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-b=
ackdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-=
contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain=
-style: ; box-sizing: border-box; border-width: 0px; border-style: solid;=
 border-color: rgb(227, 227, 227); margin: 12px 0px; unicode-bidi: plaint=
ext; font-weight: 400; font-size: 16px; line-height: 1.75; letter-spacing=
: 0.32px; color: rgb(44, 44, 54); font-family: system-ui, ui-sans-serif, =
-apple-system, BlinkMacSystemFont, sans-serif, Inter, NotoSansHans; font-=
style: normal; font-variant-ligatures: normal; font-variant-caps: normal;=
 orphans: 2; text-align: start; text-indent: 0px; text-transform: none; w=
idows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space:=
 pre-line; background-color: rgb(255, 255, 255); text-decoration-thicknes=
s: initial; text-decoration-style: initial; text-decoration-color: initia=
l;">I suggest that as a first step, we could perform basic rule-based val=
idation of the URL in unit tests=E2=80=94such as checking whether the can=
onical query matches the URI, etc. And I will do it before submitting any=
 patches modifying the url perparation logic in s3erofs implementaion.</p=
>
    <p data-spm-anchor-id=3D"a2ty_o01.29997173.0.i14.1ad3c921heqRwN"
style=3D"--tw-border-spacing-x: 0; --tw-border-spacing-y: 0; --tw-transla=
te-x: 0; --tw-translate-y: 0; --tw-rotate: 0; --tw-skew-x: 0; --tw-skew-y=
: 0; --tw-scale-x: 1; --tw-scale-y: 1; --tw-pan-x: ; --tw-pan-y: ; --tw-p=
inch-zoom: ; --tw-scroll-snap-strictness: proximity; --tw-gradient-from-p=
osition: ; --tw-gradient-via-position: ; --tw-gradient-to-position: ; --t=
w-ordinal: ; --tw-slashed-zero: ; --tw-numeric-figure: ; --tw-numeric-spa=
cing: ; --tw-numeric-fraction: ; --tw-ring-inset: ; --tw-ring-offset-widt=
h: 0px; --tw-ring-offset-color: #fff; --tw-ring-color: rgb(59 130 246 / .=
5); --tw-ring-offset-shadow: 0 0 #0000; --tw-ring-shadow: 0 0 #0000; --tw=
-shadow: 0 0 #0000; --tw-shadow-colored: 0 0 #0000; --tw-blur: ; --tw-bri=
ghtness: ; --tw-contrast: ; --tw-grayscale: ; --tw-hue-rotate: ; --tw-inv=
ert: ; --tw-saturate: ; --tw-sepia: ; --tw-drop-shadow: ; --tw-backdrop-b=
lur: ; --tw-backdrop-brightness: ; --tw-backdrop-contrast: ; --tw-backdro=
p-grayscale: ; --tw-backdrop-hue-rotate: ; --tw-backdrop-invert: ; --tw-b=
ackdrop-opacity: ; --tw-backdrop-saturate: ; --tw-backdrop-sepia: ; --tw-=
contain-size: ; --tw-contain-layout: ; --tw-contain-paint: ; --tw-contain=
-style: ; box-sizing: border-box; border-width: 0px; border-style: solid;=
 border-color: rgb(227, 227, 227); margin: 12px 0px; unicode-bidi: plaint=
ext; font-weight: 400; font-size: 16px; line-height: 1.75; letter-spacing=
: 0.32px; color: rgb(44, 44, 54); font-family: system-ui, ui-sans-serif, =
-apple-system, BlinkMacSystemFont, sans-serif, Inter, NotoSansHans; font-=
style: normal; font-variant-ligatures: normal; font-variant-caps: normal;=
 orphans: 2; text-align: start; text-indent: 0px; text-transform: none; w=
idows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space:=
 pre-line; background-color: rgb(255, 255, 255); text-decoration-thicknes=
s: initial; text-decoration-style: initial; text-decoration-color: initia=
l;">In the future, we could integrate tools that simulate an S3 service (=
e.g., <a class=3D"moz-txt-link-freetext" href=3D"https://github.com/adobe=
/S3Mock">https://github.com/adobe/S3Mock</a>) as part of our CI testing p=
ipeline (<span
style=3D"color: rgb(44, 44, 54); font-family: system-ui, ui-sans-serif, -=
apple-system, BlinkMacSystemFont, sans-serif, Inter, NotoSansHans; font-s=
ize: 16px; font-style: normal; font-variant-ligatures: normal; font-varia=
nt-caps: normal; font-weight: 400; letter-spacing: 0.32px; orphans: 2; te=
xt-align: start; text-indent: 0px; text-transform: none; widows: 2; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; back=
ground-color: rgb(255, 255, 255); text-decoration-thickness: initial; tex=
t-decoration-style: initial; text-decoration-color: initial; display: inl=
ine !important; float: none;">although this still isn't sufficient to cov=
er the compatibility differences across various cloud providers' S3 inter=
faces...</span>. )</p>
    <p><span
style=3D"color: rgb(44, 44, 54); font-family: system-ui, ui-sans-serif, -=
apple-system, BlinkMacSystemFont, sans-serif, Inter, NotoSansHans; font-s=
ize: 16px; font-style: normal; font-variant-ligatures: normal; font-varia=
nt-caps: normal; font-weight: 400; letter-spacing: 0.32px; orphans: 2; te=
xt-align: start; text-indent: 0px; text-transform: none; widows: 2; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; back=
ground-color: rgb(255, 255, 255); text-decoration-thickness: initial; tex=
t-decoration-style: initial; text-decoration-color: initial; display: inl=
ine !important; float: none;">What's your opinion?</span></p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Yifan</p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:8c2c314c-3088-4e25-ab20-63ac6402b004@linux.alibaba.com"=
>you
      could simply add
      <br>
      <br>
      #ifdef TEST
      <br>
      int main(int argc, char argv[])
      <br>
      {
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0testfunc1();=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 // and use assert() if test fails
      <br>
      =C2=A0=C2=A0=C2=A0=C2=A0testfunc2();
      <br>
      }
      <br>
      #endif
      <br>
      <br>
      and use gcc -o s3_test -Iinclude -lcurl lib/remote/s3.c to
      generate a test program.
      <br>
      <br>
      Thanks,
      <br>
      Gao Xiang
      <br>
      <br>
    </blockquote>
  </body>
</html>

--------------58HyIMKOQbjGT17m49HbQ3EO--

