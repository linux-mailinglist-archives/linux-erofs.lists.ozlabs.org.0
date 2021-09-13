Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C51840838D
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 06:30:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7D6v0hWtz2yLS
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 14:30:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1631507431;
	bh=z6FnjXJIanNHwpLWHw7sLykyu1q+5pgPeRn41FPjQuM=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Mbf/SfSddKDrWx5lObEkz6WiOmctpX2eH7Karv14X6u4A1Twy6hn+LdT3sHciy0IL
	 h2LABzSbR0hhBICRYSoBf7Ny5vN2ULT0ccMztPHuzNpLq6dZOpibKLq/wu7YUnmtdU
	 ncBdLksR1em+ZrxB0mpwm0BxWy6w9tU0Zg3j3z0Ww4V526cgx5OaiRugn0aWyZnRWF
	 vCScoiXLPbNxO22JBSDcfou+dguEqddb5xJeMp7nY1zt5TnKMsyUECDL9E0ahxkm6m
	 x8bwrKjuROoQQtgy04R7iZeZcNNWKun//Nu0Cr4TwDOQQSBlkuVeaiLI4rk68eWB1/
	 bfPK9CadRAx2g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.42;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=sYw9Dapo; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300042.outbound.protection.outlook.com [40.107.130.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7D6p4xVYz2xY6
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 14:30:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0yu6CGDnyuFWZ3zNJRjWZ6RFNoHb25JqwW7KEO7fFUO3mb5Uy6qbJ8CHNhUDx2wKge02S/2x22B8bXlngo1Q4GZiVfO/bGp51FK5hn78HoYQ7g1EbyDhngVBd7kEn8DptagM03Kyq1IkVP7fvftBd/ZkSrxnk/kQZR8qeYlIWi51zZLtxPg4N5TQqqi+ShTM9RZbZf737h4dJedhJSOe3Agc4ndVfbtoGaBo904amPTBG4EBM9vnJ3Mo91XChGS3B3PIwCb0y3ewTsJEtSCjYQfvmc7fX6oN9nMKCWUv6YxksEMjqoEy8WebiUer2m8WUFYgEcKIaH62H2CmWKc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=z6FnjXJIanNHwpLWHw7sLykyu1q+5pgPeRn41FPjQuM=;
 b=fgwV3Vrq784TLGjSIznNFlFgjgTUNwNK/6Vdt6KS8a0NAQKGeXEk0osCkapX0K54rNOFSBp+A3iynebc4YZB9ISgWuJaSozi6c6nfII4A+BGI8TI7Bs3qARzU/1thhygqiDj90oNTEEUNHLAil8qQ3dQXP/O9MAZNYdrCA5QO5rMjx5jAmSjBGtKusTRyujC3Q+rPE/cGgfsWHsI2wemrSWxwWB5/zDTwIe44VHlEVMyQZwC+/nW3uN3993tguWCulTay7MNW3zddNeJ4J4t9xDLzy/7Yboxj8MZXduUEQxyllSD+SXg8e8JEv0cPghi04Zq154gjc/b7RP21MjODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: outlook.com; dkim=none (message not signed)
 header.d=none;outlook.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3372.apcprd02.prod.outlook.com (2603:1096:4:48::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.18; Mon, 13 Sep 2021 04:30:06 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 04:30:06 +0000
Subject: Re: [PATCH v1 3/5] dump.erofs: add -S options for collecting
 statistics of the whole filesystem
To: xiang@kernel.org
References: <20210911134635.1253426-1-guoxuenan@huawei.com>
 <20210911134635.1253426-3-guoxuenan@huawei.com>
 <20210911161305.GC3160@hsiangkao-HP-ZHAN-66-Pro-G1>
Message-ID: <7790736c-0aeb-ca52-af44-cc72e168ed0f@oppo.com>
Date: Mon, 13 Sep 2021 12:30:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210911161305.GC3160@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::16) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.255.79.105) by
 HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.0 via Frontend Transport; Mon, 13 Sep 2021 04:30:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d78d24cf-a6b0-4c62-ecd8-08d9766f29cf
X-MS-TrafficTypeDiagnostic: SG2PR02MB3372:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3372649EF706FD4C1977B408C3D99@SG2PR02MB3372.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mJ9sw+9010CbMmgUPW+jSqSdAjCLTQyn0S9JRflsnhR5Ah0QH8NmyQ/LuGJdSUgndSRlCt7qqSgi7C1kRMcHX6H09jIAPUtRrnyLyAbAoCkanFIDzLi2Z8FeahLZFG+QtX+JdGtonD6qD3eB75femc7dx1QI/XW4X5i2+wZxL4hyvPJQA9+zfSsqK/l4Yx0ijsLslNFp70ahTAXEB8HOpi/iDQXooS3oRU8E548Yu3YdKqQi3QO787ZbMI/s867jmdZpxYe18iTdnlfQbVJolHT8Uo5JQp6ENgzf/MIopDwXbBLvD+3S/Nnoc5ejRaT2mfgrDLvurB3lAyNgGSTQc5QwonRkQZWr9I7ZNrNXzYdaxT2M7O/PSFednRcyuWhb2gf4JH1a3PS7KDxjJXd86PYo3vlSrLn/SdcdPisRmo+m6ygcg4tw1DHUA1XWNh7dnfkjZfu5jYdrF+8YxAIAhfZNDjtO8/IXW/iu2ANvL54Pbj0bO3BLm0RAz9M+Q3g0xFvyeyp9AvT7fKs1ysS+FexdA0CXF4fHwX8v1AYmdlAt3fYyDlHq9X85Cd4jvklQStDHgoD6RNSPW1bcUBM1eWZQiT915gQLY5vN1uv3w6nUJt5Ex7vXkYmxP3DaWQW6zP04ukFdrfESHo7Fr58h1grMltOPnQjTTkzVdtma/ZDWHF+bUhC6svlqp/9YhQ/E4O+Up49B13iuxJKNUY8vAifQCsbRmGD30s/1kPFCPc/7MHmkXzgvXYD4qrx2Qn1DEb3it4xdnTjapXi11ntKuR2s7g2Mh0r36tlewvZPFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(45080400002)(4326008)(31696002)(36756003)(8676002)(66946007)(2616005)(956004)(16576012)(38350700002)(86362001)(316002)(5660300002)(478600001)(30864003)(83380400001)(26005)(186003)(6916009)(38100700002)(31686004)(8936002)(52116002)(6486002)(66556008)(66476007)(2906002)(11606007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHFMNUlhVWMzbzhnaHowR1VJcGlFRkhQQzF0RG45Zi9jc2NqVmpTa1JTU2VE?=
 =?utf-8?B?eGxOeXhCM2pSaE1Pc2s3Njh5cEExZnF5THZDRWQxam1XZ0djS1VtL0IrdFQ5?=
 =?utf-8?B?cHRmWENJb0daY29Qbi9VNGJjVkNXYjU2V1RGeHJPVlYxMnBoL2dnNEorZm9s?=
 =?utf-8?B?Z0k2S1dzS1VqWXJVUm9DaHpsaTR3M2ZiaklpZjZFRHhWWWZwZlVJMXZmckJD?=
 =?utf-8?B?TC9IeUE5YmtlRWFuZno0QzYzd3RXWG5jbVcvYjhvN0dRbnZIamtxaW1UMTJI?=
 =?utf-8?B?c25lejFIbkRqeURxekk1UTMzQ3U5ejlTY3czWFk1clZ5TnU1em1iVlVIdWhx?=
 =?utf-8?B?NEJ6QlRpMWVQYmFXblM4bzl0c3pISDB2K3Q2TjcvWGJSU1lXZi9lT3MxV1RU?=
 =?utf-8?B?RWJqSjlNZmN0N0d3UWtZcXloZlJXWEdyZ2E5cUJwYjFGVi9Nc2FwYWQ2UjNH?=
 =?utf-8?B?Q1ZGTHpSNTVnZkJmcUFheTFmZjJ0Z201V3A2aldJcHFSdGRnYytVRGkzdHNm?=
 =?utf-8?B?aVZsckFMdmVDRm9raFg5TmIwSW5DY09sYTc5RURIZDVKdlZCWm9zYms0bHQv?=
 =?utf-8?B?OWdQZFJSdUQxbnV5bGFveTVHZjRzK1MrbGp0dDhCV0hSMTVGYnkxUFlnNzho?=
 =?utf-8?B?WjBhb2N3WExsZENXQmU2bHR0aHZJUDQzUjVMaWs5UnFiUDJWUWtYZm9QeS9u?=
 =?utf-8?B?dnlwQ3UvZXl3dUgvVUwweWRwL0dQT2E0VUlvU1RtQ0hnUkxmUG9DUFJ1K0d5?=
 =?utf-8?B?bGdGNi9Mb1kyODBoTnlXUUREbW51eUhTYitYYXdyVWVQSlN1R3RiT01jUjY3?=
 =?utf-8?B?dzVCeGdTZVQ2Zis4b0NkYldwY0paVVNIeGtuOVp6U3lPdHdkSDRPYytEaEhl?=
 =?utf-8?B?Q0lacFN0K1NWdHMrbGlZOWVFMXdRdmhvbnBDUW5GcGo4U3NXYlhxS2lLSjYz?=
 =?utf-8?B?TWRxa2FKd0hzTnRpVGx0N1R4UGN1VHFCZnIwVHFkR3FLS21vK3JxdXlkOGsx?=
 =?utf-8?B?LzdsM1pMRnhHWmlpNFFDTHRITFl2ZC9UYWNMTFlpc0R3QUo0T3lkTGg2MDBj?=
 =?utf-8?B?eWRtMFYzdktoMUNvOVFBbTJWSXluTDQxQ2wvNjJjaUdzSGhqZHhMYWZqcEFq?=
 =?utf-8?B?bjgzQWYvbmJ3dkdObDV1ajZtdXJzVFhHYjQwTXdKRVBGK05Sa2JHWmg4dHRz?=
 =?utf-8?B?VEtjZXJwN1BTSVM1VlFrVjB0cWlJN3FmNWE4ejM5WTBTV0hvVWpJMnZaZm9r?=
 =?utf-8?B?T3ZBelIwMVpqYWcxdlk4R0FxclcyWCtsWktWRGMzWHVQeWZIL1lQRXBRcDhZ?=
 =?utf-8?B?TWRwUnhKVG1Kd2VkeXpPd1VJOVpzblgwS3kzYnJCWklWcEpFUklqRWJ4Mzlv?=
 =?utf-8?B?L3hvS0VFbThBUTBjakdmT0Jrb0xwNG5LQ3NLVEE3RlpBOHUzd3VXRThwaGZu?=
 =?utf-8?B?V24ycUd2RDJPLzhlS09YZFlhSFR6aVArdi8vRWdTNVdHUnJpdXI4UmU4M3ph?=
 =?utf-8?B?QkNlRHM4NGd6Q2RSOFY3SlJZQWl1VXlYbDdVbHpGcXpISHRYc092TjJRZEtP?=
 =?utf-8?B?cTlHclA1ZEM0UjNrdnpWYUUzOWpwMWxKa2tWQ1lvM2JnWHZra1pzbTRzaW1i?=
 =?utf-8?B?TVJxZ3BMRUpIY2tSR01iTXVwN29xOGpIQnZ2NXFjeTVsSXpWTHZxd2FsNE5r?=
 =?utf-8?B?eE9vY0R5WFpQbVhGWE14bXFaODlINDNtOFJyQUNDbmRNUGdwSTZVU1VieXlD?=
 =?utf-8?Q?7z8kJQx1C9178iExi3rkgRG8YfABc+/MswuLrLy?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78d24cf-a6b0-4c62-ecd8-08d9766f29cf
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 04:30:06.5775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdWOIOu7q5zA7jR0wlKa9Z+HR5POlNICkZjAJ0CEU9ZXVAWILNgA1dsjOFYDInh8YAz/+FISlqOQpPY4d34f5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3372
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2021/9/12 0:13, Gao Xiang 写道:
> (+Cc Jianan.)
>
> On Sat, Sep 11, 2021 at 09:46:33PM +0800, Guo Xuenan wrote:
>> From: mpiglet <mpiglet@outlook.com>
>>
>> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
>> Signed-off-by: mpiglet <mpiglet@outlook.com>
>> ---
>>   dump/main.c | 474 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 474 insertions(+)
>>
>> diff --git a/dump/main.c b/dump/main.c
>> index 25ac89f..b0acc0b 100644
>> --- a/dump/main.c
>> +++ b/dump/main.c
>> @@ -19,10 +19,78 @@
>>   
>>   struct dumpcfg {
>>   	bool print_superblock;
>> +	bool print_statistic;
>>   	bool print_version;
>>   };
>>   static struct dumpcfg dumpcfg;
>>   
>> +static const char chart_format[] = "%-16s	%-11d %8.2f%% |%-50s|\n";
>> +static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
>> +static char *file_types[] = {
>> +	".so",
>> +	".png",
>> +	".jpg",
>> +	".xml",
>> +	".html",
>> +	".odex",
>> +	".vdex",
>> +	".apk",
>> +	".ttf",
>> +	".jar",
>> +	".json",
>> +	".ogg",
>> +	".oat",
>> +	".art",
>> +	".rc",
>> +	".otf",
>> +	".txt",
>> +	"others",
>> +};
>> +enum {
>> +	SOFILETYPE = 0,
>> +	PNGFILETYPE,
>> +	JPEGFILETYPE,
>> +	XMLFILETYPE,
>> +	HTMLFILETYPE,
>> +	ODEXFILETYPE,
>> +	VDEXFILETYPE,
>> +	APKFILETYPE,
>> +	TTFFILETYPE,
>> +	JARFILETYPE,
>> +	JSONFILETYPE,
>> +	OGGFILETYPE,
>> +	OATFILETYPE,
>> +	ARTFILETYPE,
>> +	RCFILETYPE,
>> +	OTFFILETYPE,
>> +	TXTFILETYPE,
>> +	OTHERFILETYPE,
>> +};
> Why we need enums here? Can these be resolved with some array index?
>
>> +
>> +#define	FILE_SIZE_BITS	30
>> +struct statistics {
>> +	unsigned long blocks;
>> +	unsigned long files;
>> +	unsigned long files_total_size;
>> +	unsigned long files_total_origin_size;
>> +	double compress_rate;
>> +	unsigned long compressed_files;
>> +	unsigned long uncompressed_files;
>> +
>> +	unsigned long regular_files;
>> +	unsigned long dir_files;
>> +	unsigned long chardev_files;
>> +	unsigned long blkdev_files;
>> +	unsigned long fifo_files;
>> +	unsigned long sock_files;
>> +	unsigned long symlink_files;
>> +
>> +	unsigned int file_type_stat[OTHERFILETYPE + 1];
>> +	unsigned int file_org_size[FILE_SIZE_BITS];
> What do "FILE_SIZE_BITS" and "file_org_size" mean?
>
>> +	unsigned int file_comp_size[FILE_SIZE_BITS];
>> +};
>> +static struct statistics stats;
>> +
>>   static struct option long_options[] = {
>>   	{"help", no_argument, 0, 1},
>>   	{0, 0, 0, 0},
>> @@ -33,6 +101,7 @@ static void usage(void)
>>   	fputs("usage: [options] erofs-image \n\n"
>>   		"Dump erofs layout from erofs-image, and [options] are:\n"
>>   		"-s          print information about superblock\n"
>> +		"-S      print statistic information of the erofs-image\n"
>>   		"-v/-V      print dump.erofs version info\n"
>>   		"-h/--help  display this help and exit\n", stderr);
>>   }
>> @@ -51,6 +120,9 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>>   		case 's':
>>   			dumpcfg.print_superblock = true;
>>   			break;
>> +		case 'S':
>> +			dumpcfg.print_statistic = true;
>> +			break;
>>   		case 'v':
>>   		case 'V':
>>   			dumpfs_print_version();
>> @@ -78,6 +150,116 @@ static int dumpfs_parse_options_cfg(int argc, char **argv)
>>   	return 0;
>>   }
>>   
>> +static int z_erofs_get_last_cluster_size_from_disk(struct erofs_map_blocks *map,
>> +		erofs_off_t last_cluster_size,
>> +		erofs_off_t *last_cluster_compressed_size)
> Hmmm... do we really need the exact compressed bytes?
> or just compressed blocks is enough?
>
> "compressed blocks" can be gotten in erofs inode.
>
> Btw, although I think it's useful for fsck (check if an erofs is correct).
>
>> +{
>> +	int ret;
>> +	int decomp_len;
>> +	int compressed_len = 0;
>> +	char *decompress;
>> +	char raw[Z_EROFS_PCLUSTER_MAX_SIZE] = {0};
>> +
>> +	ret = dev_read(raw, map->m_pa, map->m_plen);
>> +	if (ret < 0)
>> +		return -EIO;
>> +
>> +	if (erofs_sb_has_lz4_0padding()) {
>> +		compressed_len = map->m_plen;
>> +	} else {
>> +		// lz4 maximum compression ratio is 255
>> +		decompress = (char *)malloc(map->m_plen * 255);
>> +		if (!decompress) {
>> +			erofs_err("allocate memory for decompress space failed");
>> +			return -1;
>> +		}
>> +		decomp_len = LZ4_decompress_safe_partial(raw, decompress,
>> +				map->m_plen, last_cluster_size,
>> +				map->m_plen * 10);
>> +		if (decomp_len < 0) {
>> +			erofs_err("decompress last cluster to get decompressed size failed");
>> +			free(decompress);
>> +			return -1;
>> +		}
>> +		compressed_len = LZ4_compress_destSize(decompress, raw,
>> +				&decomp_len, Z_EROFS_PCLUSTER_MAX_SIZE);
>> +		if (compressed_len < 0) {
>> +			erofs_err("compress to get last extent size failed\n");
>> +			free(decompress);
>> +			return -1;
>> +		}
>> +		free(decompress);
>> +		// dut to the use of lz4hc (can use different compress level),
>> +		// our normal lz4 compress result may be bigger
>> +		compressed_len = compressed_len < map->m_plen ?
>> +			compressed_len : map->m_plen;
>> +	}
>> +
>> +	*last_cluster_compressed_size = compressed_len;
>> +	return 0;
>> +}
>> +
>> +static int z_erofs_get_compressed_size(struct erofs_inode *inode,
>> +		erofs_off_t *size)
>> +{
>> +	int err;
>> +	erofs_blk_t compressedlcs;
>> +	erofs_off_t last_cluster_size;
>> +	erofs_off_t last_cluster_compressed_size;
>> +	struct erofs_map_blocks map = {
>> +		.index = UINT_MAX,
>> +		.m_la = inode->i_size - 1,
>> +	};
>> +
>> +	err = z_erofs_map_blocks_iter(inode, &map);
> (add Jianan here.)
>
> Can we port the latest erofs kernel fiemap code to erofs-utils, and add
> some functionality to get the file distribution as well when the fs isn't
> mounted?
Hi Xiang,

I have sent the patch and verified it with a similar function. Better to 
use the
new interface here.

Thanks,
Jianan
>
>> +	if (err) {
>> +		erofs_err("read nid %ld's last block failed\n", inode->nid);
>> +		return err;
>> +	}
>> +	compressedlcs = map.m_plen >> inode->z_logical_clusterbits;
>> +	*size = (inode->u.i_blocks - compressedlcs) * EROFS_BLKSIZ;
>> +	last_cluster_size = inode->i_size - map.m_la;
>> +
>> +	if (!(map.m_flags & EROFS_MAP_ZIPPED)) {
>> +		*size += last_cluster_size;
>> +	} else {
>> +		err = z_erofs_get_last_cluster_size_from_disk(&map,
>> +				last_cluster_size,
>> +				&last_cluster_compressed_size);
>> +		if (err) {
>> +			erofs_err("get nid %ld's last extent size failed",
>> +					inode->nid);
>> +			return err;
>> +		}
>> +		*size += last_cluster_compressed_size;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int get_file_compressed_size(struct erofs_inode *inode,
>> +		erofs_off_t *size)
> erofs_dump_get_file_occupied_blocks?
>
>> +{
>> +	int err;
>> +
>> +	*size = 0;
>> +	switch (inode->datalayout) {
>> +	case EROFS_INODE_FLAT_INLINE:
>> +	case EROFS_INODE_FLAT_PLAIN:
>> +		stats.uncompressed_files++;
>> +		*size = inode->i_size;
>> +		break;
>> +	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
>> +	case EROFS_INODE_FLAT_COMPRESSION:
>> +		stats.compressed_files++;
>> +		err = z_erofs_get_compressed_size(inode, size);
>> +		if (err) {
>> +			erofs_err("get compressed file size failed\n");
>> +			return err;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>>   static void dumpfs_print_superblock(void)
>>   {
>>   	time_t time = sbi.build_time;
>> @@ -111,6 +293,294 @@ static void dumpfs_print_superblock(void)
>>   
>>   }
>>   
>> +static int get_file_type(const char *filename)
>> +{
>> +	char *postfix = strrchr(filename, '.');
>> +	int type = SOFILETYPE;
>> +
>> +	if (postfix == NULL)
>> +		return OTHERFILETYPE;
>> +	while (type < OTHERFILETYPE) {
>> +		if (strcmp(postfix, file_types[type]) == 0)
>> +			break;
>> +		type++;
>> +	}
>> +	return type;
>> +}
>> +
>> +// file count、file size、file type
> It'd be better to avoid C++ comments...
>
>> +static int read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
>> +{
>> +	struct erofs_inode vi = { .nid = nid};
>> +	int err;
>> +	char buf[EROFS_BLKSIZ];
>> +	char filename[PATH_MAX + 1];
>> +	erofs_off_t offset;
>> +
>> +	err = erofs_read_inode_from_disk(&vi);
>> +	if (err)
>> +		return err;
>> +
>> +	offset = 0;
>> +	while (offset < vi.i_size) {
>> +		erofs_off_t maxsize = min_t(erofs_off_t,
>> +			vi.i_size - offset, EROFS_BLKSIZ);
>> +		struct erofs_dirent *de = (void *)buf;
>> +		struct erofs_dirent *end;
>> +		unsigned int nameoff;
>> +
>> +		err = erofs_pread(&vi, buf, maxsize, offset);
>> +		if (err)
>> +			return err;
>> +
>> +		nameoff = le16_to_cpu(de->nameoff);
>> +
>> +		if (nameoff < sizeof(struct erofs_dirent) ||
>> +		    nameoff >= PAGE_SIZE) {
>> +			erofs_err("invalid de[0].nameoff %u @ nid %llu",
>> +				  nameoff, nid | 0ULL);
>> +			return -EFSCORRUPTED;
>> +		}
>> +		end = (void *)buf + nameoff;
>> +		while (de < end) {
>> +			const char *dname;
>> +			unsigned int dname_len;
>> +			struct erofs_inode inode = { .nid = de->nid };
>> +			int actual_size_mark;
>> +			int original_size_mark;
>> +			erofs_off_t actual_size = 0;
>> +			erofs_off_t original_size;
>> +
>> +			nameoff = le16_to_cpu(de->nameoff);
>> +			dname = (char *)buf + nameoff;
>> +
>> +			if (de + 1 >= end)
>> +				dname_len = strnlen(dname, maxsize - nameoff);
>> +			else
>> +				dname_len =
>> +					le16_to_cpu(de[1].nameoff) - nameoff;
>> +
>> +			/* a corrupted entry is found */
>> +			if (nameoff + dname_len > maxsize ||
>> +				dname_len > EROFS_NAME_LEN) {
>> +				erofs_err("bogus dirent @ nid %llu",
>> +						le64_to_cpu(de->nid) | 0ULL);
>> +				DBG_BUGON(1);
>> +				return -EFSCORRUPTED;
>> +			}
>> +			if (de->nid != nid && de->nid != parent_nid)
>> +				stats.files++;
>> +
>> +			memset(filename, 0, PATH_MAX + 1);
>> +			memcpy(filename, dname, dname_len);
>> +
>> +			switch (de->file_type) {
>> +			case EROFS_FT_UNKNOWN:
>> +				break;
>> +			case EROFS_FT_REG_FILE:
>> +				err = erofs_read_inode_from_disk(&inode);
>> +				if (err) {
>> +					erofs_err("read file inode from disk failed!");
>> +					return err;
>> +				}
>> +				original_size = inode.i_size;
>> +				stats.files_total_origin_size += original_size;
>> +				stats.regular_files++;
>> +
>> +				err = get_file_compressed_size(&inode,
>> +						&actual_size);
>> +				if (err) {
>> +					erofs_err("get file size failed\n");
>> +					return err;
>> +				}
>> +				stats.files_total_size += actual_size;
>> +				stats.file_type_stat[get_file_type(filename)]++;
>> +
>> +				original_size_mark = 0;
>> +				actual_size_mark = 0;
>> +				actual_size >>= 10;
>> +				original_size >>= 10;
>> +
>> +				while (actual_size || original_size) {
>> +					if (actual_size) {
>> +						actual_size >>= 1;
>> +						actual_size_mark++;
>> +					}
>> +					if (original_size) {
>> +						original_size >>= 1;
>> +						original_size_mark++;
>> +					}
>> +				}
>> +
>> +				if (original_size_mark >= FILE_SIZE_BITS - 1)
>> +					stats.file_org_size[FILE_SIZE_BITS - 1]++;
>> +				else
>> +					stats.file_org_size[original_size_mark]++;
>> +				if (actual_size_mark >= FILE_SIZE_BITS - 1)
>> +					stats.file_comp_size[FILE_SIZE_BITS - 1]++;
>> +				else
>> +					stats.file_comp_size[actual_size_mark]++;
>> +				break;
>> +
>> +			case EROFS_FT_DIR:
>> +				if (de->nid != nid && de->nid != parent_nid) {
>
>
>> +					stats.dir_files++;
>> +					stats.uncompressed_files++;
>> +					err = read_dir(de->nid, nid);
>> +					if (err) {
>> +						fprintf(stderr,
>> +								"parse dir nid %llu error occurred\n",
>> +								de->nid);
>> +						return err;
>> +					}
>> +				}
>> +				break;
>> +			case EROFS_FT_CHRDEV:
>> +				stats.chardev_files++;
>> +				stats.uncompressed_files++;
> How about using an array instead?
>
>> +				break;
>> +			case EROFS_FT_BLKDEV:
>> +				stats.blkdev_files++;
>> +				stats.uncompressed_files++;
>> +				break;
>> +			case EROFS_FT_FIFO:
>> +				stats.fifo_files++;
>> +				stats.uncompressed_files++;
>> +				break;
>> +			case EROFS_FT_SOCK:
>> +				stats.sock_files++;
>> +				stats.uncompressed_files++;
>> +				break;
>> +			case EROFS_FT_SYMLINK:
>> +				stats.symlink_files++;
>> +				stats.uncompressed_files++;
>> +				break;
>> +			}
>> +			++de;
>> +		}
>> +		offset += maxsize;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void dumpfs_print_statistic_of_filetype(void)
>> +{
>> +	fprintf(stderr, "Filesystem total file count:         %lu\n",
>> +			stats.files);
>> +	fprintf(stderr, "Filesystem regular file count:       %lu\n",
>> +			stats.regular_files);
>> +	fprintf(stderr, "Filesystem directory count:          %lu\n",
>> +			stats.dir_files);
>> +	fprintf(stderr, "Filesystem symlink file count:       %lu\n",
>> +			stats.symlink_files);
>> +	fprintf(stderr, "Filesystem character device count:   %lu\n",
>> +			stats.chardev_files);
>> +	fprintf(stderr, "Filesystem block device count:       %lu\n",
>> +			stats.blkdev_files);
>> +	fprintf(stderr, "Filesystem FIFO file count:          %lu\n",
>> +			stats.fifo_files);
>> +	fprintf(stderr, "Filesystem SOCK file count:          %lu\n",
>> +			stats.sock_files);
> Also a loop can be used here.
>
>> +}
>> +
>> +static void dumpfs_print_chart_row(char *col1, unsigned int col2,
>> +		double col3, char *col4)
>> +{
>> +	char row[500] = {0};
>> +
>> +	sprintf(row, chart_format, col1, col2, col3, col4);
>> +	fprintf(stderr, row);
>> +}
>> +
>> +static void dumpfs_print_chart_of_file(unsigned int *file_counts,
>> +		unsigned int len)
>> +{
>> +	char col1[30];
>> +	unsigned int col2;
>> +	double col3;
>> +	char col4[400];
>> +	unsigned int lowerbound = 0;
>> +	unsigned int upperbound = 1;
>> +
>> +	fprintf(stderr, header_format, ">=(KB) .. <(KB) ", "count",
>> +			"ratio", "distribution");
>> +	for (int i = 0; i < len; i++) {
>> +		memset(col1, 0, 30);
> 		memset(col1, 0, sizeof(col1));
>
>> +		memset(col4, 0, 400);
> 		memset(col4, 0, sizeof(col4));
>
> Thanks,
> Gao Xiang
>
>> +		if (i == len - 1)
>> +			strcpy(col1, " others");
>> +		else if (i <= 6)
>> +			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
>> +		else
>> +
>> +			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
>> +		col2 = file_counts[i];
>> +		col3 = (double)(100 * col2) / (double)stats.regular_files;
>> +		memset(col4, '#', col3 / 2);
>> +		dumpfs_print_chart_row(col1, col2, col3, col4);
>> +		lowerbound = upperbound;
>> +		upperbound <<= 1;
>> +	}
>> +}
>> +
>> +static void dumpfs_print_chart_of_file_type(char **file_types, unsigned int len)
>> +{
>> +	char col1[30];
>> +	unsigned int col2;
>> +	double col3;
>> +	char col4[401];
>> +
>> +	fprintf(stderr, header_format, "type", "count", "ratio",
>> +			"distribution");
>> +	for (int i = 0; i < len; i++) {
>> +		memset(col1, 0, 30);
>> +		memset(col4, 0, 401);
>> +		sprintf(col1, "%-17s", file_types[i]);
>> +		col2 = stats.file_type_stat[i];
>> +		col3 = (double)(100 * col2) / (double)stats.regular_files;
>> +		memset(col4, '#', col3 / 2);
>> +		dumpfs_print_chart_row(col1, col2, col3, col4);
>> +	}
>> +}
>> +
>> +static void dumpfs_print_statistic_of_compression(void)
>> +{
>> +	stats.compress_rate = (double)(100 * stats.files_total_size) /
>> +		(double)(stats.files_total_origin_size);
>> +	fprintf(stderr, "Filesystem compressed files:         %lu\n",
>> +			stats.compressed_files);
>> +	fprintf(stderr, "Filesystem uncompressed files:       %lu\n",
>> +			stats.uncompressed_files);
>> +	fprintf(stderr, "Filesystem total original file size: %lu Bytes\n",
>> +			stats.files_total_origin_size);
>> +	fprintf(stderr, "Filesystem total file size:          %lu Bytes\n",
>> +			stats.files_total_size);
>> +	fprintf(stderr, "Filesystem compress rate:            %.2f%%\n",
>> +			stats.compress_rate);
>> +}
>> +
>> +static void dumpfs_print_statistic(void)
>> +{
>> +	int err;
>> +
>> +	stats.blocks = sbi.blocks;
>> +	err = read_dir(sbi.root_nid, sbi.root_nid);
>> +	if (err) {
>> +		erofs_err("read dir failed");
>> +		return;
>> +	}
>> +
>> +	dumpfs_print_statistic_of_filetype();
>> +	dumpfs_print_statistic_of_compression();
>> +
>> +	fprintf(stderr, "\nOriginal file size distribution:\n");
>> +	dumpfs_print_chart_of_file(stats.file_org_size, 17);
>> +	fprintf(stderr, "\nOn-Disk file size distribution:\n");
>> +	dumpfs_print_chart_of_file(stats.file_comp_size, 17);
>> +	fprintf(stderr, "\nFile type distribution:\n");
>> +	dumpfs_print_chart_of_file_type(file_types, OTHERFILETYPE + 1);
>> +}
>> +
>>   int main(int argc, char **argv)
>>   {
>>   	int err = 0;
>> @@ -138,5 +608,9 @@ int main(int argc, char **argv)
>>   	if (dumpcfg.print_superblock)
>>   		dumpfs_print_superblock();
>>   
>> +	if (dumpcfg.print_statistic)
>> +		dumpfs_print_statistic();
>> +
>> +
>>   	return 0;
>>   }
>> -- 
>> 2.25.4
>>

