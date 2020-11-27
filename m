Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E53882C6397
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 12:11:08 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjBkw6BR9zDrdR
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 22:11:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.45;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=CzMYqDmZ; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310045.outbound.protection.outlook.com [40.107.131.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjBkS0KJ8zDrdJ
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 22:10:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItFjWIrM3g3THKbuOoSY91VU4vAQiUmTHLL0/smgh8KMxBuTRQChm0A8K5vo+/NK7KC8DVnrcMqu9+wwcZnDUDgz9Z+XLGQjZe/57hwRnDuCxn1rKr902oEc8OQ87jMcUHQVVC/3rUGDBtSCRP4kbVbUp06QEEtnxw7As3BN+/417kU4J6eZ/9YzZJEx7WE81SddR1LcPGZNLc6lKsS5j05/+JCrzK0SNsR7rHeiIZ1J/KXU7+OLwmfkdzona0W4h0S5LdEuvIYaXvYhwnGrN+SK6DpKjuevDCefJZpnsZL40xWR9imgo7tQ6iiSwX1x5NBRXKZmZfa7DTZ85M1BBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTvS8tIngiotCSkZuCYburweKHwE1b5k4HHCH4Y0eBE=;
 b=U1bV6GvXSSef1yzYQD/IFQefn2YVovj2qw/waltl6NcHFa6JIjO3P0mdB5II0mWwhbWJbfcl2tIWE1S6KpBvLe/210NE6U1PBKq8nxgxXPjINwesVQ2Z7z3X5kamoNVG3tnVQWpRPP1tuFbrs0jZSaG+pi3PjLydYyGvqD8/EiYiuhDMU0q4W30G5tcPwma+StD89lEjomAiomMOb1PeTY/Pl6xTMqyYsvgLkNYSZsTWIR//OXtUCjeYP/alJkX1qeihODtgJv8xfncX3RL53k4Bn2mdDVD/yssyFZLzUDyFrT3lEspGi/M4I+yo+JYP1t7wqy6Qpd/lMysalBQQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTvS8tIngiotCSkZuCYburweKHwE1b5k4HHCH4Y0eBE=;
 b=CzMYqDmZ8FEDoUEL8mI04ut+y67MQNLlpq+WA/yDr4sqJoHRQHn9ggoEklqnGL+FaGQfchwfKtadFP9M+PWTuOTSdUFd2dHJ1Ldhr5BL+OTNuxi++nW6wVRvppR4fx336rftD5xEORlBoRXMWDjIEjowuqFc3TYGI8s30EF5ZR8=
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3276.apcprd02.prod.outlook.com (2603:1096:4:45::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.24; Fri, 27 Nov 2020 11:10:33 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::34fa:80a2:c5d5:8efd%6]) with mapi id 15.20.3589.025; Fri, 27 Nov 2020
 11:10:33 +0000
Subject: Re: [PATCH v2 1/1] erofs-utils: fix use after free in closedir
To: linux-erofs@lists.ozlabs.org
References: <20201127110616.34232-1-huangjianan@oppo.com>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <dc3c8a96-fd74-bb66-ad6a-562d32b52b5b@oppo.com>
Date: Fri, 27 Nov 2020 19:10:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
In-Reply-To: <20201127110616.34232-1-huangjianan@oppo.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR0302CA0009.apcprd03.prod.outlook.com
 (2603:1096:202::19) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by
 HK2PR0302CA0009.apcprd03.prod.outlook.com (2603:1096:202::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.8 via Frontend Transport; Fri, 27 Nov 2020 11:10:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec53d67a-5f20-4a06-a487-08d892c50f05
X-MS-TrafficTypeDiagnostic: SG2PR02MB3276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3276FD5114D0C1569E01C6D7C3F80@SG2PR02MB3276.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzJQC6oEKK4FADiX/m2Nmrzv8HF9PTOKiKi6AzWJ2QNRxLIaoOokAI9PJLg0zjKf5fG6JuB85+0Q+c8nMbMjpMQyBNZDAc5+qBMKJvQLyKb7QbRsTX29fd981Lx4zXxHsrvg1jOnMhlwS/5obRyx2tFtnRPTJfX8hz8uSe39u2+IxOvsecjUEC522K3pSlASRDCLFAtsJ6xpB1gzIOZj42W0svTmVrrTOTeI+F+stPtrT3YLE8kgZ0gSGbuvBGwh5ygJXxjuv4EdNF8fOAngAutzvnAYcRsDIXWxvbgkN2scWh6KxAyC2xwE3XfETLP/lgFUGWS5qrUJt3AEwNGP9hvnwPl5YghlKgZ055QyipAOGnhXQCh7au71Gvlx3kNZL3EJhT/QoXONJxQHII4nog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(316002)(52116002)(16576012)(66476007)(4326008)(956004)(2616005)(66556008)(16526019)(6666004)(5660300002)(86362001)(186003)(26005)(31686004)(66946007)(2906002)(107886003)(83380400001)(36756003)(6486002)(8676002)(8936002)(478600001)(31696002)(6916009)(11606006)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?gb2312?B?S1RqNjdUVU5uWFZ3VEpJY2VTZW1SMlB4bGlrTGZyMWsxVDI2RHp4WU5pNHQ3?=
 =?gb2312?B?em10OVVLekpDMXhIeVEyc3Y3SjZsQTd3bEdvY2FZVkdhSDVwYkRES3NETVda?=
 =?gb2312?B?WmxtRHlROXBpQnlHRkpVQU5PU0FUalBMNldOL2VJT1ZXYzQ0WWlhM0NNaFB4?=
 =?gb2312?B?QnpLMzhweWZwNVp1ZTFQcnZQNmlWY042YXlsODl1STcvcElDV0ZqVkNVRWl3?=
 =?gb2312?B?N3V2Mi8vUnB3NExONUJtcFkyY0MvQzhIYVZpNUZ0aEZ1WEpuTEEvMGJvbHNm?=
 =?gb2312?B?TzFxRDh6MzNTeGZCNTBubE5Yd3ZrT1Nnc0Fhdm1hcGR3TDBRbjlJODNUd2V0?=
 =?gb2312?B?eE9HVW5wWlJaenFETDZlR0N2T2VrUmZQem9aKytQNVlGdEQ3WHgzeHo5N3Rz?=
 =?gb2312?B?NFJnZkpyamVNVUk1bWtFcUlxNVYrV2pJRFFZQTNHWlhPS3E3OXJnc2V0Nyt0?=
 =?gb2312?B?bFY0UE5jNmdXb0ZUVTNvVjF5RDBHS0pLOU9XYWtEbDJycHJydWZnbkdNcmVl?=
 =?gb2312?B?cjNDYnRHNGxORlRkWVFPVk9mUkdITE5pREhENGFOMm5BdW5UcjRZdjQ4dEw1?=
 =?gb2312?B?MEV4VUhVVG9oR2VlVm5hdWhmVk1hcHRaa2Y3b1IxKzdoL1hoOTBjYm9ULzU1?=
 =?gb2312?B?L1dkenJKRE5pVVhFV1AwK3ltYndPbWk3N0x3bXdDNXA3ajk2MzZRenpwbTZh?=
 =?gb2312?B?UDRhYUZJalY5SWRLMUhKcFRxRlMwS0Rma2lOSHRab1dIN00zZi9vTXhzM0FK?=
 =?gb2312?B?SVNhdWZmOHJrajVEQVBoK0ZDcGxnTTVPbzQwUkwrR3o5ZnZMeUlubEhkNDNZ?=
 =?gb2312?B?cDBqeFNPK2NYNmFYMHBVam1oVTlobFlzR1FKdFk0dE5EZjdPZ2RieUdiVXN6?=
 =?gb2312?B?Qmcza3RmdEVKU1A4RVp4Q3FpK1lNYjBydHBaaGtFSENTZkw5eDlzTmxUc2c5?=
 =?gb2312?B?UUFYWUV2djAvemZZdDYySU1lY3NxS2I2S3YzWUdpbE5qZmFBMjBINlkyRCtF?=
 =?gb2312?B?ci9PNkNpU1dJL05VWmxTcklFaFZrVFBESXFwSldCLzB6NzdOeG5UUVpLbi8z?=
 =?gb2312?B?ZE5YTWh4Y3g3ZHFUN3BhaXZ6Ly8velZmSDZybDZYZVNabXJrRzNtU2xDYm5j?=
 =?gb2312?B?eWZabUtXVnlMc2RoTDYvUnQxUTBmMmQ2NTVHSmNCMjBCTUhoMVc2eGxaMmFs?=
 =?gb2312?B?Z0JhR0NzaUN4OUx3RFZsMHZMaVdMbFR4aGkwQ1l6ekxPQjczL1prRS9aamlw?=
 =?gb2312?B?OUROYkZDRkFkd3JhMUhRdGlaVTVFL3cvYVRaY1lHbWxNN0JzWEc5MC9kQnd2?=
 =?gb2312?Q?9Bg7J/FNHxxSc=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec53d67a-5f20-4a06-a487-08d892c50f05
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 11:10:33.4144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DC2aQHnibQBTlkNj4+oa1RZpHIIIbdVgJ550Ry+4DU3gHRQTDn9QHXrOWKui6FDIWGpuhSB3whxLzhdjkEHd+A==
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
Cc: liufeibao@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Sorry for sending the wrong PATCH v2.

ÔÚ 2020/11/27 19:06, Huang Jianan Ð´µÀ:
> No need to closedir _dir again since it has been released.
>
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   lib/inode.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/inode.c b/lib/inode.c
> index eb2e0f2..388d21d 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -958,11 +958,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>   
>   	ret = erofs_prepare_dir_file(dir);
>   	if (ret)
> -		goto err_closedir;
> +		goto err;
>   
>   	ret = erofs_prepare_inode_buffer(dir);
>   	if (ret)
> -		goto err_closedir;
> +		goto err;
>   
>   	if (IS_ROOT(dir))
>   		erofs_fixup_meta_blkaddr(dir);
> @@ -988,7 +988,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>   fail:
>   			d->inode = NULL;
>   			d->type = EROFS_FT_UNKNOWN;
> -			goto err_closedir;
> +			goto err;
>   		}
>   
>   		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
> @@ -1003,6 +1003,7 @@ fail:
>   
>   err_closedir:
>   	closedir(_dir);
> +err:
>   	return ERR_PTR(ret);
>   }
>   
