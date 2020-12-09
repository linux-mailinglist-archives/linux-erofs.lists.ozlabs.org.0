Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337AB2D38DB
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 03:35:22 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrLkH1sjVzDql5
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 13:35:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.82;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=SO/32DPo; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310082.outbound.protection.outlook.com [40.107.131.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrLk84Rh2zDqhD
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 13:35:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpw2SUStijrOs/aASmqb3N4bH42Fg9F9iWzJP8MKtTbQVzAIybfPHlijNs46CyPgXDA0RXZEMQPGnYWyvp2UuQiGXNK4FNbP+/nPipGCMHNqGXX+AHsXt+Kj1IeEZL2XT+1bLRZZRjenDsBDU6w234th3r6ljIGg1lvYmYIG8oniAhGaknRRdckaHQCt3SayjcA2tbctWneQGFLDy0XpfW3M76Z5thfuIkoaxc1z6Nw7WiZkOS5HN73S8Z6fHKsc1ma9r6f1ExUDghgwqAJx8Ixr2iagHAGVG/V0Iq7Ek52PTKevzQGBBXAWZ/wEtd8j7GgfwQDycYVEj2uCKJzBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koacWKx/N90K7oNTyjdtbKSjv4Du0iM/R/koPS01ELg=;
 b=g8L8T9kWOp3ls+/j6Jh+TyFvnlEFKQF2F4yGPfkVADh3wKopRRSpGV9J5JeHWEyOtb4zV9qCpdGYV43phQCzPU2xeT02OJeY/JIWVEPYNXOXGQXKIIS0BUIwEGPRnYW5uc+UsuhVVeacNhILHtb+BBg49bty7z//I9YG/YlBZR5Sr+wRJbGp9P57Uoy/Rnip2BbUnAbEYBV9B58wjX4PK3UGQCOqhWDdtyH60HtC8ecTMB4SWmhI34SSw1962wKtm5U4eJ6bbt7RivZSBiekGAtpT/LY6qhOyKc2z7oRZcH0wfEQDewhUQJVlG9hUYo/2O/t6eZWsL5/UZIeWamr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koacWKx/N90K7oNTyjdtbKSjv4Du0iM/R/koPS01ELg=;
 b=SO/32DPohl8j062FCXgPxbj0/q6UYG3Ri6FcH/OX182+7lKcVS21+bd92r40uuFAihH8iWHmTt6KbPoLdccz8N69DnSEvWrsfXlo0DHusPgut4Uk17lo5w9Nf1yMO9Ui2c4NpvoS+wNPvhuXTiq9LWQmzflOuWiFuy1HGwIRAQU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3276.apcprd02.prod.outlook.com (2603:1096:4:45::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 9 Dec 2020 02:35:04 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 02:35:04 +0000
Subject: Re: [PATCH v3] erofs: avoiding using generic_block_bmap
To: linux-erofs@lists.ozlabs.org
References: <20201208131108.7607-1-huangjianan@oppo.com>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <c71fe6a9-06ba-3871-6e0b-104f58df1df7@oppo.com>
Date: Wed, 9 Dec 2020 10:34:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201208131108.7607-1-huangjianan@oppo.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::18) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by
 HK0PR01CA0054.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 02:35:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f14f2c60-99f1-445e-a10b-08d89beb0901
X-MS-TrafficTypeDiagnostic: SG2PR02MB3276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3276BE0A348EE7B7E81CFC38C3CC0@SG2PR02MB3276.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uN3yNn3TiRwTvxf34HRDTk+W1bl+ViNjXflaoN6J2AQfIx0TPIhUu5z6QsJa7j5HKu+HjG9IFtSFvI/H6ER+7AO9LyKaOae7Gg7XGhLE8Y4Phi1+gVVlQmf0QZ1uBPRkCiuVJy68QkS4t6X+rqJTpWE89oU/scXhnemaGx8GcsSzBpQhmtX+LbT+Pp1n52LIoxjEK7Sn0BndjcTg3tr36AoYUC5XvM8AUE+99GUpIAxuJH8Au/Z/5Sv5ubF8Rq95xZ0nXMqfuWdxi6gG6vh3caOOdBPQ2O5G06uwdJuc+HAFyWQg6Fn1WTMfhIBkUUP4fYaVMNpOIHvGfjSlZA1b+4rCAs8fshUuy6QO3u76Yi57bNza2yfrej2i7kTjY0/fRdINb+OBeKXESiqITmv3d+UiljTTpEXKPVTPYyGY45/GxrvJMi92AsErEp48V+kFuvf4TDZv+711JiJruT4kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(508600001)(6916009)(26005)(36756003)(8936002)(8676002)(52116002)(2906002)(186003)(34490700003)(16526019)(31696002)(4326008)(6666004)(16576012)(66556008)(31686004)(5660300002)(66476007)(6486002)(83380400001)(86362001)(66946007)(956004)(2616005)(11606006)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?gb2312?B?amd5RzlrRjZaV1BOUk1Nc3ZIb0R5L0RyMmFHR0hQVGtsZGwxUTZ5eW1UanZt?=
 =?gb2312?B?RmdwY0lLSGppWjRaN3c2cWpWcjVDMEdpVThJVnN6Q085ZUJBWExJMVNhS1NK?=
 =?gb2312?B?ZHRqT29mNkNLc1pOR3MyaVhTU0hFaEZqMnFJSWJUT1A0RDQxbEk1K2ZpTXJ6?=
 =?gb2312?B?SEVYRHVpQWtoUjJ6MDlHRjFMRGQzOENYY21VYnA0bWtOemN2Tko4U2FzT3pV?=
 =?gb2312?B?TlFxbU5qSUNtSGVSeXBrQS9tVGZPYnZzUWx0d3V2aG5tU01lN29iQUZPMHBq?=
 =?gb2312?B?SSt6SmxTNVNiREZwR1kyaTE2Mkt6Q2RKUENtQzU4MGJFMnZKM1hBektld3JZ?=
 =?gb2312?B?aEx4bitOQkxFS0p5cmF0YStVM1Bkd2dqNVhIaGNobFJzdDBXWFoycmc2dFZv?=
 =?gb2312?B?WmVCbFVVekdNNFlzQkJ1Z21kQXU5a1VSbzFNN2svNHNGRVdQMlFtR0U5NlF1?=
 =?gb2312?B?MGhYQlY0SDZuWlNSNnNGeFlnWTRBV2Y3RURzRFdWK0RUMDd4c3dTSUNnZjR3?=
 =?gb2312?B?WDBweDNlalhnQnZHelZqTi9mdlNvcjNLMVZHK0JSeTNjOG16UEJhQWcwczAz?=
 =?gb2312?B?WlV0Y2YrY2g5c2FSR2xzYmR5UGNNd2J4eitaSEdoemdYS2N4SmZGQXA2NzNv?=
 =?gb2312?B?ZVI1bmJUL3BmcnRjdVI5cWR3bTBQd2w5NjNoa3JUV245YnBBM05LOS91MGFS?=
 =?gb2312?B?ZnUwTmNYeDYxTUs0VHgzRmdhcER5VGZ0QzU5T0NLUWFuTUIrSXN0bThNSWpV?=
 =?gb2312?B?aFQvN0x0TG80Tm5qc0JJWlFsVmR1VzBDYmFTVmxJWGN2VC90bURkV1JncmNV?=
 =?gb2312?B?WDBZQzFaTDJwMExxREErVE9zVXdWQmQwSmd0TGlLcjV5a2c2VkNyL3VOT0Qz?=
 =?gb2312?B?b3hObDFUUDMwTzk3NHVZU2czRzVBM2txT1YyUTBqM0YrSFF6YUhjTVZiQVZM?=
 =?gb2312?B?UzQ1V2JtNnRIcUl2SGs4ZWlGZE5Pellvbkhob1d4Wjk2SVlpdnMwR2MxWHdn?=
 =?gb2312?B?RUhhNVc5VUZhQ0Q2VitnOStIUEFNUlQ4RllVQVFjRFNmaHowQno2WE81VldB?=
 =?gb2312?B?VkE3cEFwNkxDYzFLUGZQcERBd3AxZng0eGg0dkd0MkdqMWh4NlV6eE9DK0NR?=
 =?gb2312?B?bmxxYmRza0tMN1B0MkJDaHBXQ0NPNFExRHJHWVlHaDRxNG12QTNOWVU1TTNH?=
 =?gb2312?B?dGoxQkxPYW9EN2hscDFXWnZGZmpGNFB0QjFtYXluMk9iaUh6cHZDK2U5RVIv?=
 =?gb2312?B?UWxzUUw1Wk5TcENBOENhdk9NQ0FmckEwa0sxeW1FOHV2cGNjZ2ptZHkyREo2?=
 =?gb2312?Q?ww5rIBuNw6QTs=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 02:35:04.1088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: f14f2c60-99f1-445e-a10b-08d89beb0901
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hlhG5yzr7Bh7ssLPbIUzyyZNfvlH3MQtuQbNdD0y/t6EYD1j/Q9BWBdCsQJnmoIzZHTPwbaF7gx4gn9jmhLQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3276
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


ÔÚ 2020/12/8 21:11, Huang Jianan Ð´µÀ:
> iblock indicates the number of i_blkbits-sized blocks rather than
> sectors.
>
> In addition, considering buffer_head limits mapped size to 32-bits,
> should avoid using generic_block_bmap.
>
> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   fs/erofs/data.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 347be146884c..399ffd857c50 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -312,36 +312,26 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>   		submit_bio(bio);
>   }
>   
> -static int erofs_get_block(struct inode *inode, sector_t iblock,
> -			   struct buffer_head *bh, int create)
> -{
> -	struct erofs_map_blocks map = {
> -		.m_la = iblock << 9,
> -	};
> -	int err;
> -
> -	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> -	if (err)
> -		return err;
> -
> -	if (map.m_flags & EROFS_MAP_MAPPED)
> -		bh->b_blocknr = erofs_blknr(map.m_pa);
> -
> -	return err;
> -}
> -
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>   {
>   	struct inode *inode = mapping->host;
> +	struct erofs_map_blocks map = {
> +		.m_la = blknr_to_addr(iblock),

Sorry for my mistake, it should be:

.m_la = blknr_to_addr(block),

> +	};
> +	sector_t blknr = 0;
>   
>   	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
>   		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
>   
>   		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
> -			return 0;
> +			goto out;
>   	}
>   
> -	return generic_block_bmap(mapping, block, erofs_get_block);
> +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> +		blknr = erofs_blknr(map.m_pa);
> +
> +out:
> +	return blknr;
>   }
>   
>   /* for uncompressed (aligned) files and raw access for other files */
