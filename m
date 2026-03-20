Return-Path: <linux-erofs+bounces-2874-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xzrdIbywvGmJ2AIAu9opvQ
	(envelope-from <linux-erofs+bounces-2874-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 03:28:12 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1D2D521A
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 03:28:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcRLb3YSzz2xm5;
	Fri, 20 Mar 2026 13:28:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773973687;
	cv=none; b=DEgDP8Wwz4KLDlnBQCi/7X/UaxU9xKC1P4UYc8fjkQJ857iclw0wePBOpi8JCtzMTl11ebcqF/PMnQFN7TXYplhe2wy9wEp7YqPzuNVBYtPh7nnXfS58dUxI/D7P2UY9HGK4reeJq7/+qrailCrObMA1f6hH3W3vzyK+d6fIhlFJXz48GFOxPV0kZ+cdnB4nIMcLpViZzkQ6KxzqS+ZZbPtCLNCu4wVKPkiasvpzhHSsy2wa2W4SRnq82qVWFU3LO21Xj35oFivoLb1BDl/KwgvQMqnYsmL8gue6sC6vtldN3DA/K3PMI/1jxRBAVo6p9sf5+74dAN4Ndbi77rfLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773973687; c=relaxed/relaxed;
	bh=JWNgKPpBPSzdynVIcn2Wu5iM+Ey8iUOrVTPT8lNK/NQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=fFAuEuESwPUU+PYLhd7qr2hv2iYQWuz+QFI17TFgixRG/BxobQGQifikegm5CAmRlaY0uZEWWiobFriQhVF2HeirCBxDLnM8OvBAY0UCFrWMJP2HT4kjIf94gnSnmojhPsK3Ean98mXfem2ByXCzKIyeb1b83kzSJBaouoSttbzez14+agJwhR13FRvG+7JIqvSAU7I/8mNicEd/FDky5uLdtyXLXcBMG415tZ0iiu6/lvsYSTpsn/H/zFGLTXgAMkWqL7itBCsWA/RgR6bp1BRXK/xOaKc3SZoR6B7m1GG0Ouray2eUyRvKRzLZ6REq/QMT5NGkkYBa4jdm1xYH2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xsYjktP0; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xsYjktP0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcRLW4rJMz2xm3
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 13:28:00 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JWNgKPpBPSzdynVIcn2Wu5iM+Ey8iUOrVTPT8lNK/NQ=;
	b=xsYjktP0DTCOxSN0VWZoYBW8eoOTtqn+pGbGyAxDldxbF0e/tSdow/8g73YCDz+1bATofInJB
	cQLx+G3NAyFmORg771WMzvQBU8lcmNO9TiqdlTmK/kiUn21ecm+JrmV7j1ws691jkPWwkhfhK+S
	w0dX02AnTWKWyPSgKRcnoYQ=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fcRDP5cCtzmV66;
	Fri, 20 Mar 2026 10:22:45 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 573BA40561;
	Fri, 20 Mar 2026 10:27:47 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 20 Mar 2026 10:27:46 +0800
Content-Type: multipart/alternative;
	boundary="------------CKbAosbcIMxqI2yE4bGDSkTG"
Message-ID: <7abae239-f45c-4489-9fa1-9e48e8b738be@huawei.com>
Date: Fri, 20 Mar 2026 10:27:33 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: fix QPL job leak on early error paths
 in z_erofs_decompress_qpl() After z_erofs_qpl_get_job() succeeds, two
 early-return error paths bypass z_erofs_qpl_put_job(), leaking the QPL job
 handle: - Line 200: return -EFSCORRUPTED (when inputmargin >= inputsize) -
 Line 205: return -ENOMEM (when malloc fails for decodedskip buffer) Fix by
 replacing the bare returns with goto out_inflate_end, which already handles
 both z_erofs_qpl_put_job() and free(buff).
To: Shubham Vishwakarma <smsharma3121@gmail.com>, Gao Xiang
	<hsiangkao@linux.alibaba.com>
CC: Ajay Rajera <newajay.11r@gmail.com>, <linux-erofs@lists.ozlabs.org>
References: <20260319221136.2126-1-smsharma3121@gmail.com>
 <CAMhhD9hbenqz2z2pRQ1EoSNttATsTnW9BZcgFVZ1VPCzAciHiw@mail.gmail.com>
 <0b0ad26c-f462-4274-aaad-6a8e079c0963@linux.alibaba.com>
 <592df2af-2109-410f-88a3-b774655f11a8@linux.alibaba.com>
 <CAPs1YC4Us+bPMKsGAUywWcp5sWzvTX6D-+naVz1y3M6F-iwXwA@mail.gmail.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <CAPs1YC4Us+bPMKsGAUywWcp5sWzvTX6D-+naVz1y3M6F-iwXwA@mail.gmail.com>
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [2.30 / 15.00];
	LONG_SUBJ(3.00)[477];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2874-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:smsharma3121@gmail.com,m:hsiangkao@linux.alibaba.com,m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 61C1D2D521A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--------------CKbAosbcIMxqI2yE4bGDSkTG
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vishwakarma,


Just a quick note for you and all the beginning committers:

Before submitting any patch to our community mailing list, please 
carefully read the contribution guidelines (we follow the Linux kernel 
process: [1]).

You're welcome to use AI agents to help check whether the patch obeys 
the guidelines, but please remember to personally review your changes, 
test locally, and understand what you're submitting.


Also we are about to publish specific guidelines for AI-assisted content.


Finally, before sending any email to the mailing list, we strongly 
recommend sending a test to your own inbox first—messages posted to the 
list are permanent and cannot be edited or retracted.


[1] https://docs.kernel.org/process/submitting-patches.html

[ This email is generated with help with Qwen3.5-plus: translation from 
Chinese to English ]


Thanks,

Yifan Zhao


On 2026/3/20 10:04, Shubham Vishwakarma wrote:
> Hi Gao,
>
> I understand the concern, but I want to be honest: if I had used AI to 
> draft the initial submission, it likely would have been sent without 
> those formatting errors.
>
> The issues with the invalid email address and the oversized subject 
> line occurred because I was unfamiliar with sending via the SMTP CLI. 
> I used GPT to help me configure the CLI tool, which led to the 
> mistakes you saw.
>
> I appreciate the feedback on the patch. If there is still doubt 
> regarding my work, I will continue to submit more patches to 
> demonstrate my ability.
>
> Thanks,
>
> Shubham Vishwakarma
>
>
> On Fri, Mar 20, 2026 at 7:11 AM Gao Xiang 
> <hsiangkao@linux.alibaba.com> wrote:
>
>
>
>     On 2026/3/20 09:37, Gao Xiang wrote:
>     >
>     >
>     > On 2026/3/20 09:16, Ajay Rajera wrote:
>     >> Hi Vi-shub,
>     >> just a review :
>     >> I think the fix looks correct and it is the right approach but the
>     >> commit message formatting needs work. The entire description is
>     in the
>     >> subject line. Per kernel conventions, the subject should be a short
>     >> one-liner, e.g: erofs-utils: lib: fix QPL job leak on early error
>     >> paths
>     >> The detailed explanation (which error paths leak, why, and how
>     the fix
>     >> works) should go in the commit message body, separated from the
>     >> subject.
>     >>
>     >> So you can resend with the subject/body split fixed? so It will
>     look more clear.
>     >
>     > yes, the commit message is in a mess.
>
>     BTW, I don't know who is using the email address
>     <yifan@pku.edu.cn>, and the recipient doesn't exist.
>
>     Here, I want to say, I have to identfy you as another
>     AI bot.
>
>     Thanks,
>     Gao Xiang
>
>     >
>     > Thanks,
>     > Gao Xiang
>     >
>     >> Thanks, Ajay
>     >
>
--------------CKbAosbcIMxqI2yE4bGDSkTG
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Vishwakarma,</p>
    <p><br>
    </p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Just a quick note for you and all the beginning committers:</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Before submitting any patch to our community mailing list, please carefully read the contribution guidelines (we follow the Linux kernel process: [1]).</span></p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">You're welcome to use AI agents to help check whether the patch obeys the guidelines, but please remember to personally review your changes, test locally, and understand what you're submitting.</span></p>
    <p><br>
    </p>
    <p>Also we are about to <span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">publish specific guidelines for AI-assisted content.</span></p>
    <p><br>
    </p>
    <p><span
style="color: rgb(29, 29, 31); font-family: system-ui, ui-sans-serif, -apple-system, BlinkMacSystemFont, Inter, NotoSansHans, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-line; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Finally, before sending any email to the mailing list, we strongly recommend sending a test to your own inbox first—messages posted to the list are permanent and cannot be edited or retracted.</span></p>
    <p><br>
    </p>
    <p>[1] <a class="moz-txt-link-freetext" href="https://docs.kernel.org/process/submitting-patches.html">https://docs.kernel.org/process/submitting-patches.html</a></p>
    <p>[ This email is generated with help with Qwen3.5-plus:
      translation from Chinese to English ]</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Yifan Zhao</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026/3/20 10:04, Shubham Vishwakarma
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPs1YC4Us+bPMKsGAUywWcp5sWzvTX6D-+naVz1y3M6F-iwXwA@mail.gmail.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>Hi Gao,</div>
        <div><br>
        </div>
        <div>I understand the concern, but I want to be honest: if I had
          used AI to draft the initial submission, it likely would have
          been sent without those formatting errors.</div>
        <div><br>
        </div>
        <div>The issues with the invalid email address and the oversized
          subject line occurred because I was unfamiliar with sending
          via the SMTP CLI. I used GPT to help me configure the CLI
          tool, which led to the mistakes you saw.</div>
        <div><br>
        </div>
        <div>I appreciate the feedback on the patch. If there is still
          doubt regarding my work, I will continue to submit more
          patches to demonstrate my ability.</div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div><br>
        </div>
        <div>Shubham Vishwakarma</div>
        <br>
      </div>
      <br>
      <div class="gmail_quote gmail_quote_container">
        <div dir="ltr" class="gmail_attr">On Fri, Mar 20, 2026 at
          7:11 AM Gao Xiang &lt;<a
            href="mailto:hsiangkao@linux.alibaba.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">hsiangkao@linux.alibaba.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
          <br>
          On 2026/3/20 09:37, Gao Xiang wrote:<br>
          &gt; <br>
          &gt; <br>
          &gt; On 2026/3/20 09:16, Ajay Rajera wrote:<br>
          &gt;&gt; Hi Vi-shub,<br>
          &gt;&gt; just a review :<br>
          &gt;&gt; I think the fix looks correct and it is the right
          approach but the<br>
          &gt;&gt; commit message formatting needs work. The entire
          description is in the<br>
          &gt;&gt; subject line. Per kernel conventions, the subject
          should be a short<br>
          &gt;&gt; one-liner, e.g: erofs-utils: lib: fix QPL job leak on
          early error<br>
          &gt;&gt; paths<br>
          &gt;&gt; The detailed explanation (which error paths leak,
          why, and how the fix<br>
          &gt;&gt; works) should go in the commit message body,
          separated from the<br>
          &gt;&gt; subject.<br>
          &gt;&gt;<br>
          &gt;&gt; So you can resend with the subject/body split fixed?
          so It will look more clear.<br>
          &gt; <br>
          &gt; yes, the commit message is in a mess.<br>
          <br>
          BTW, I don't know who is using the email address<br>
          &lt;<a href="mailto:yifan@pku.edu.cn" target="_blank"
            moz-do-not-send="true" class="moz-txt-link-freetext">yifan@pku.edu.cn</a>&gt;,
          and the recipient doesn't exist.<br>
          <br>
          Here, I want to say, I have to identfy you as another<br>
          AI bot.<br>
          <br>
          Thanks,<br>
          Gao Xiang<br>
          <br>
          &gt; <br>
          &gt; Thanks,<br>
          &gt; Gao Xiang<br>
          &gt; <br>
          &gt;&gt; Thanks, Ajay<br>
          &gt; <br>
          <br>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------CKbAosbcIMxqI2yE4bGDSkTG--

