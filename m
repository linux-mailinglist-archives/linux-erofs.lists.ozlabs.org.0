Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1741A8DE
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 08:24:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HJTxD0PVWz2yNr
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Sep 2021 16:24:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=TMbgQSpQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=outlook.com (client-ip=2a01:111:f400:fe9c::800;
 helo=jpn01-os2-obe.outbound.protection.outlook.com;
 envelope-from=mpiglet@outlook.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=TMbgQSpQ; 
 dkim-atps=neutral
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-os2jpn01olkn0800.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe9c::800])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HJTx459vcz2yHf
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Sep 2021 16:24:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd6ovRefM8TIXaRUApT6fNM+9BUo+hdoe8zJM6JZTKRr1wAz9YTidAgc1MyAkPAphdaOuDXtMzgNLAtV3Rf0Nw4QVkI9F+N9vP5aeKjm0Qhzwt7zpCxxUdHctFkM4I8fM1Y4IwImzKE314Lf/ODZET8J+mJ2SW8MS6Hp5iiEvxTCl5u3S8/73wXIGcUgezELjTFtO/XDAus0Rkg0bQe8glzKHoo2bxuDoGmJO5BlkPKEk4+80pSymfEBzthPbunuwws+JRPgpkcfM/ee3YCvcQtdsP0zhrmALwiXpD4RH5RqBOCHzPukcIJZ4YhX1a4eclGJacSpz674lSaItuxEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GFQ7Ca7aBKJSBj+eulzzyHfnv/n2fMpVTCFYkbElASw=;
 b=BJYoKOVo3P1TDgrMvLeDB4QY/ulJk80vaBTEawmzZpLoHdQ6Oi2Rmx0fyovABJHHLg9HfD4DpCiuwMhsGin5hOmtCVf1HXUUP2p7yqMOyu9Bi469ddM3zhkBHClbpm1/6AnxPY4r2Srw0f61gUGHW3oklifSbTOq9oVZsNEUY3BeJIFIuEFq4lgUSuoPnNQyMjWwOqJ204RUPNoFN03nnq1uYB108h0CbVUzeFM+Y6zfBFE4vaJKXC7PHpArUsXdCrZXFRL2Lp3a+LQo8zz1cyd+gW6s+ngfrP9umnGGGjLtFPAOI+XvT0RcgNMVqS75QULfWwy4Q7NliXXC3DbBIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFQ7Ca7aBKJSBj+eulzzyHfnv/n2fMpVTCFYkbElASw=;
 b=TMbgQSpQVtltJOxfx3Tuo6bvb9phFAihKwpki07a3sBdtLOsedEETee8105yxn7WTkzWOqOC34nocK8Jvs4Bc9iKtURzEnfCYAITuiU7K31LqYsdZM1O0s6zTvC+UJJYzibwPDglNUFWjW5hOTxnmtIGhXQXC9XZYRX2BBpkFTBDQz1POiSJCKp+mA1xr+jSji+lgd2TtdEaZLx9zfa9NsqN6yVgOcMnjUZZuMM01d58L5m9RAFyNmerWfdw16/IwFFVTSz6re/U0o0M6CtqTaAi4Z6kMrHPXYbp9ftkb+mHDRigIJhGW99hZhbfJOCnNMnr5mgroggw7k0ST6nBRg==
Received: from OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:f7::12)
 by OS0P286MB0419.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 06:23:33 +0000
Received: from OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e1a3:2da2:e20b:d8aa]) by OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e1a3:2da2:e20b:d8aa%6]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 06:23:33 +0000
Content-Type: multipart/alternative;
 boundary="------------20Iz5t0rtLmR6i4WGt3WUvSF"
Message-ID: <OSZP286MB07097AE45E9D391B0049F661B2A89@OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM>
Date: Tue, 28 Sep 2021 14:23:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 1/5] erofs-utils: introduce dump.erofs
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Guo Xuenan <guoxuenan@huawei.com>
References: <20210915093537.2579575-1-guoxuenan@huawei.com>
 <YU/nRm9ug/kFXHBD@B-P7TQMD6M-0146.local>
 <YVJ/DVHlUG83A3Jk@B-P7TQMD6M-0146.local>
From: Qi Wang <mpiglet@outlook.com>
In-Reply-To: <YVJ/DVHlUG83A3Jk@B-P7TQMD6M-0146.local>
X-TMN: [jOEGfbbJB6ck9uBYEbolx4bUcrQ52GKJaXLCcmhz3FKNUKSFyOnC4UCwn2yZ1124]
X-ClientProxiedBy: HKAPR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:c9::11) To OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:f7::12)
X-Microsoft-Original-Message-ID: <6530b2b0-031e-98b0-4abf-2db92564bfac@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPV6:2400:dd01:1001:1028:a130:f4f:7752:390a]
 (2400:dd01:1001:1028:a130:f4f:7752:390a) by
 HKAPR03CA0024.apcprd03.prod.outlook.com (2603:1096:203:c9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.9 via Frontend Transport; Tue, 28 Sep 2021 06:23:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c3267e-0749-44f4-67fc-08d982487f66
X-MS-TrafficTypeDiagnostic: OS0P286MB0419:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbmRvJscJLEbnIjkIGW4zIs9LbqVhzxg3u+31H9eSyvDF9Ms/QTH+sH/jGFttrp9E7XZEWqZ9DixSmF+82FsPVyT2t65QVjv1v/7QSohdU6LQJRlO2TnPigughW/oxDi2q7TXX56L+wAUCRVji7lDrdk3g2Wcu8TJILG7Y9urIFDqHG/E1SJZEU1p0NkkGqmjcru7+IABxzyJtC0DmuySNwBwffwCFQZ+30FcxJ+yqre8tQCCeTa77u/RzhkoiNOr3TGoXEJN3n9og1tCHbmpu+Y4UbcvIqNI2ePQQcCf3gv416R7g9R6e2QynvTGndHQtfLc8xU24F1HuBSoBkKa1io/5Sl9aI6yfOuRAhm4ZhR+JxkAYqZgVVjfJDfIlCkmDkv3tfA1TJP3sEjjcDmVSs+5vQ97T1CbzHKZgKoRXlIvUFwo1W2ZyyCoXnkWHCQobuDSJxGEg1du8PDzWxrp+sGgFCzAVKZFAPz11F2yk0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D/mITT3diUCQbT/zMkYkTJAm4PfLnu5eBCdREouU9A3+yTENrdrlj2VuS0l/Ka79PhUll8PX6FeT64AryNalzN75iBt7eDALtmzpoB+XM/MecrmBeoyWbnOXEcICxypReS50NC2sHYRGo2Sj5QeTA14Ec9nNQDyp/smimP743AKoelLzdC1lZoRxFKriQWj3UlPjJUr3sKXcrnZoL3hIew==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c3267e-0749-44f4-67fc-08d982487f66
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 06:23:33.8778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0P286MB0419
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

--------------20Iz5t0rtLmR6i4WGt3WUvSF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2021/9/28 10:33 上午, Gao Xiang wrote:
> Hi,
>
> On Sun, Sep 26, 2021 at 11:21:42AM +0800, Gao Xiang wrote:
>> Hi Xuenan and Qi,
>>
>> On Wed, Sep 15, 2021 at 05:35:33PM +0800, Guo Xuenan wrote:
>>> From: Wang Qi<mpiglet@outlook.com>
>>>
>>> Add dump-tool for erofs to facilitate users directly
>>> analyzing the erofs image file.
>>>
>>> Signed-off-by: Guo Xuenan<guoxuenan@huawei.com>
>>> Signed-off-by: Wang Qi<mpiglet@outlook.com>
>> I'm almost fine with the series, and I will merge some of the patches
>> later.
>>
>> Due to busy work, my original plan was to fix some nits by myself and
>> apply. Anyway, I will reply some comments this evening...
> I've merged the first 2 patches into dev branch with modification (so no
> need to resend the first two patches).
>
> The rest patches are still a bit messy, I've set up a new
> experimental-dump branch, please check out:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/?h=experimental-dump
>
> There are some stuffs needing to be resolved in advance:
>   1) rename all "dumpfs_" prefix into "erofsdump_";
>   2) I feel still uncomfortable when reading get_path_by_nid() and
>      erofs_read_dir(). Could we refactor them by introducing
>      erofs_for_each_dir() or likewise?
>   3) file_category_types and the switch in dumpfs_print_inode() are
>      duplicated to me. I think one of them can be removed instead.
>   4) please help using "filefrag -v -b1" style when printing extent info
>      in erofsdump_show_inode_phy(), like below:
>
>   ext:     logical_offset:        physical_offset: length:   expected: flags:
>     0:        0..   20479: 21788270592..21788291071:  20480:             last,eof
>
> Thanks,
> Gao Xiang
>
Thanks for your reply! I will refactor the code according to your advice.

Thanks,
Wang Qi

--------------20Iz5t0rtLmR6i4WGt3WUvSF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>Hi,
</pre>
    <div class="moz-cite-prefix">On 2021/9/28 10:33 上午, Gao Xiang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YVJ%2FDVHlUG83A3Jk@B-P7TQMD6M-0146.local">
      <pre class="moz-quote-pre" wrap="">Hi,

On Sun, Sep 26, 2021 at 11:21:42AM +0800, Gao Xiang wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi Xuenan and Qi,

On Wed, Sep 15, 2021 at 05:35:33PM +0800, Guo Xuenan wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">From: Wang Qi <a class="moz-txt-link-rfc2396E" href="mailto:mpiglet@outlook.com">&lt;mpiglet@outlook.com&gt;</a>

Add dump-tool for erofs to facilitate users directly
analyzing the erofs image file.

Signed-off-by: Guo Xuenan <a class="moz-txt-link-rfc2396E" href="mailto:guoxuenan@huawei.com">&lt;guoxuenan@huawei.com&gt;</a>
Signed-off-by: Wang Qi <a class="moz-txt-link-rfc2396E" href="mailto:mpiglet@outlook.com">&lt;mpiglet@outlook.com&gt;</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I'm almost fine with the series, and I will merge some of the patches
later.

Due to busy work, my original plan was to fix some nits by myself and
apply. Anyway, I will reply some comments this evening...
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I've merged the first 2 patches into dev branch with modification (so no
need to resend the first two patches).

The rest patches are still a bit messy, I've set up a new
experimental-dump branch, please check out:
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/?h=experimental-dump">https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/?h=experimental-dump</a>

There are some stuffs needing to be resolved in advance:
 1) rename all &quot;dumpfs_&quot; prefix into &quot;erofsdump_&quot;;
 2) I feel still uncomfortable when reading get_path_by_nid() and
    erofs_read_dir(). Could we refactor them by introducing
    erofs_for_each_dir() or likewise?
 3) file_category_types and the switch in dumpfs_print_inode() are
    duplicated to me. I think one of them can be removed instead.
 4) please help using &quot;filefrag -v -b1&quot; style when printing extent info
    in erofsdump_show_inode_phy(), like below:

 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..   20479: 21788270592..21788291071:  20480:             last,eof

Thanks,
Gao Xiang

</pre>
    </blockquote>
    <pre>Thanks for your reply! I will refactor the code according to your advice.

Thanks,
Wang Qi</pre>
  </body>
</html>
--------------20Iz5t0rtLmR6i4WGt3WUvSF--
